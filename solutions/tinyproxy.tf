/* ====================================================
## setup a tinyproxy host
## Author: Werner Brandt
## =================================================== */

module "tinyproxy_instance_profile" {
  source                = "../tf_modules/iam/instance_profile"
  instance_profile_name = "${var.tinyproxy_instance_profile_name}"
  instance_profile_role = "${module.tinyproxy_iam_role.iam_role_name}"
}

module "tinyproxy_iam_role" {
  source                  = "../tf_modules/iam/role"
  iam_rolename            = "${var.tinyproxy_iam_role_name}"
  assume_role_policy_name = "${var.tinyproxy_policy_filename}"
  role_iam_policy_arn     = ["${module.tinyproxy_instance_policy.iam_policy_arn}"]
  default_path            = "${path.cwd}/policies"
}

module "tinyproxy_instance_policy" {
  source          = "../tf_modules/iam/policy"
  iam_policy_name = "${var.tinyproxy_iam_role_policy}"
  default_path    = "${path.cwd}"
}



module "sg_tinyproxy" {
  source = "../tf_modules/network/security_groups"

  #Naming variables
  service     = "sg"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "tinyproxy"
  ext         = ""
  delimiter   = "-"

  # Resource variables
  vpcid         = "${module.main_vpc.vpc_id}"
  sgdescription = "tinyproxy security group (only SSH inbound access is allowed)"

  sg_in_cidr_rules = [{
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
    from_port   = "22"
    to_port     = "22"
    description = "ssh inbound"
  },{
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
    from_port   = "8888"
    to_port     = "8888"
    description = "http inbound"
  }]

  sg_eg_cidr_rules = [{
    protocol    = "all"
    cidr_blocks = "0.0.0.0/0"
    from_port   = "0"
    to_port     = "65535"
    description = "all outbound allowed"
  }]
}


module "tinyproxy_sg_elb" {
  source        = "../tf_modules/network/security_groups"
  vpcid         = "${module.main_vpc.vpc_id}"
  sgdescription = "ELB tinyproxy security group (only SSH inbound access is allowed)"

   #Naming variables
  service     = "sg"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "tinyproxy"
  ext         = ""
  attributes  = ["elb"]
  delimiter   = "-"

    // Egress rules from CIDR
   sg_in_cidr_rules = [{
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
    from_port   = "22"
    to_port     = "22"
    description = "ssh inbound"
  },{
    protocol    = "tcp"
    cidr_blocks = "0.0.0.0/0"
    from_port   = "8888"
    to_port     = "8888"
    description = "http inbound"
  }]

  // Ingress rules from CIDR
  sg_eg_cidr_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}


module "lconfig_tinyproxy" {
  source              = "../tf_modules/compute/launch_configuration"
  lc_name_prefix      = "tinyproxy-lc-"
  lc_image_id         = "${lookup(var.tinyproxy_id, var.region)}"
  lc_instance_type    = "${var.tinyproxy_lc_instance_type}"
  lc_security_groups  = ["${module.sg_tinyproxy.sg_id}"]
  lc_key_name         = "${module.sshkey.key_name}"
  lc_instance_profile = "${module.tinyproxy_instance_profile.instance_profile_arn}"
#  lc_user_data        = "${file("${path.cwd}/user_data/tinyproxy_config.yml")}"

  #Naming variables
  service     = "lc"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "tinyproxy"
  ext         = ""
  delimiter   = "-"
}

module "asg_tinyproxy" {
  source                   = "../tf_modules/compute/asg"
  asg_launch_configuration = "${module.lconfig_tinyproxy.lc_name}"
  asg_vpc_zone_identifier  = ["${module.public_internal_subnet_a.subnet_id}", "${module.public_internal_subnet_b.subnet_id}"]
  asg_max_size             = "${var.tinyproxy_asg_max}"
  asg_min_size             = "${var.tinyproxy_asg_min}"
  asg_desired_capactiy     = "${var.tinyproxy_asg_capacity}"
  asg_load_balancers       = ["${module.tinyproxy_elb.elb_id}"]

  # Lifecycle Hook
  # TODO: Use the right default values - not sure if this is correct
  asg_initial_lifecycle_hook_default_result = "CONTINUE"

  asg_initial_lifecycle_hook_heartbeat_timeout = "180"

  #Naming variables
  service     = "asg"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "tinyproxy"
  ext         = ""
  tags        = "${map("propagete_at_launch", "true")}"
  delimiter   = "-"
}

module "tinyproxy_elb" {
  source = "../tf_modules/compute/elb"

  elb_subnets                   = ["${module.public_external_subnet_a.subnet_id}", "${module.public_external_subnet_b.subnet_id}"]
  elb_internal                  = "${var.tinyproxy_elb_internal}"
  elb_cross_zone_load_balancing = "${var.tinyproxy_elb_cross_zone_load_balancing}"
  elb_target                    = "${var.tinyproxy_elb_target}"
  elb_security_groups           = ["${module.sg_tinyproxy.sg_id}"]

    # Listener
  elb_instance_port = "8888"
  elb_instance_protocol = "tcp"
  elb_port = "8888"
  elb_protocol = "tcp"

  # Connection draining
  elb_connection_draining = "${var.tinyproxy_elb_connection_draining}"

  #Naming variables
  service     = "elb"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "tinyproxy"
  ext         = ""
  delimiter   = "-"
}
