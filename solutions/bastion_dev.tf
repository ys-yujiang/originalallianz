/* ====================================================
## setup a Bation host
## Author: Werner Brandt
## =================================================== */

module "bastion_instance_profile_dev" {
  source                = "../tf_modules/iam/instance_profile"
  instance_profile_name = "${var.bastiond_instance_profile_name}"
  instance_profile_role = "${module.bastion_iam_role_dev.iam_role_name}"
}

module "bastion_iam_role_dev" {
  source                  = "../tf_modules/iam/role"
  iam_rolename            = "${var.bastiond_iam_role_name}"
  assume_role_policy_name = "${var.bastiond_policy_filename}"
  role_iam_policy_arn     = ["${module.bastion_instance_policy_dev.iam_policy_arn}"]
  default_path            = "${path.cwd}/policies"
}

module "bastion_instance_policy_dev" {
  source          = "../tf_modules/iam/policy"
  iam_policy_name = "${var.bastiond_iam_role_policy}"
  default_path    = "${path.cwd}"
}



module "sg_bastion_dev" {
  source = "../tf_modules/network/security_groups"

  #Naming variables
  service     = "sg"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "bastion"
  ext         = ""
  attributes  = ["dev"]
  delimiter   = "-"

  # Resource variables
  vpcid         = "${module.main_vpc.vpc_id}"
  sgdescription = "Bastion security group (only SSH inbound access is allowed)"

  sg_in_cidr_rules = [{
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
    from_port   = "22"
    to_port     = "22"
    description = "ssh inbound"
  }]

  sg_eg_cidr_rules = [{
    protocol    = "all"
    cidr_blocks = "${var.egress_cidr_dev}"
    from_port   = "0"
    to_port     = "65535"
    description = "all outbound allowed"
  }]
}


module "bastion_sg_elb_dev" {
  source        = "../tf_modules/network/security_groups"
  vpcid         = "${module.main_vpc.vpc_id}"
  sgdescription = "ELB Bastion security group (only SSH inbound access is allowed)"

   #Naming variables
  service     = "sg"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "bastion"
  ext         = ""
  attributes  = ["dev", "elb"]
  delimiter   = "-"

    // Egress rules from CIDR
   sg_in_cidr_rules = [{
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
    from_port   = "22"
    to_port     = "22"
    description = "ssh inbound"
  }]

  // Ingress rules from CIDR
  sg_eg_cidr_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "${var.main_vpccidr}"
    },
  ]
}


module "lconfig_bastion_dev" {
  source              = "../tf_modules/compute/launch_configuration"
  lc_name_prefix      = "bastion-lc-"
  lc_image_id         = "${lookup(var.ec2_iam_id, var.region)}"
  lc_instance_type    = "${var.bastion_lc_instance_type}"
  lc_security_groups  = ["${module.sg_bastion_dev.sg_id}"]
  lc_key_name         = "${module.sshkey.key_name}"
  lc_instance_profile = "${module.bastion_instance_profile_dev.instance_profile_arn}"
  lc_user_data        = "${file("${path.cwd}/user_data/bastion_config.yml")}"

  #Naming variables
  service     = "lc"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "bastion"
  ext         = ""
  attributes  = ["dev"]
  delimiter   = "-"
}

module "asg_bastion_dev" {
  source                   = "../tf_modules/compute/asg"
  asg_launch_configuration = "${module.lconfig_bastion_dev.lc_name}"
  asg_vpc_zone_identifier  = ["${module.public_internal_subnet_a.subnet_id}", "${module.public_internal_subnet_b.subnet_id}"]
  asg_max_size             = "1"
  asg_min_size             = "1"
  asg_desired_capactiy     = "1"

  # Lifecycle Hook
  # TODO: Use the right default values - not sure if this is correct
  asg_initial_lifecycle_hook_default_result = "CONTINUE"

  asg_initial_lifecycle_hook_heartbeat_timeout = "180"

  #Naming variables
  service     = "asg"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "bastion"
  ext         = ""
  attributes  = ["dev"]
  tags        = "${map("propagete_at_launch", "true")}"
  delimiter   = "-"
}

module "bastion_elb_dev" {
  source = "../tf_modules/compute/elb"

  elb_subnets                   = ["${module.public_external_subnet_a.subnet_id}", "${module.public_external_subnet_b.subnet_id}"]
  elb_internal                  = "${var.bastion_elb_internal}"
  elb_cross_zone_load_balancing = "${var.bastion_elb_cross_zone_load_balancing}"
  elb_target                    = "${var.bastion_elb_target}"
  elb_security_groups           = ["${module.sg_bastion_dev.sg_id}"]

    # Listener
  elb_instance_port = "22"
  elb_instance_protocol = "tcp"
  elb_port = "22"
  elb_protocol = "tcp"

  # Connection draining
  elb_connection_draining = "${var.bastion_elb_connection_draining}"

  #Naming variables
  service     = "elb"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "bastion"
  ext         = ""
  attributes  = ["dev"]
  delimiter   = "-"
}
