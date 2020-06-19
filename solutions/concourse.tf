# Description: Terraform code to create a Concourse box in the shared environments
# Author : Patrick Hynes - patrick.hynes@cloudreach.com
# Architecture : (ELB + ASG + LC)

// Instance profile for Concourse CI Server
module "concourse_instance_profile" {
  source                = "../tf_modules/iam/instance_profile"
  instance_profile_name = "${var.concourse_instance_profile_name}"
  instance_profile_role = "${module.concourse_iam_role.iam_role_name}"
}

// Concourse IAM role
module "concourse_iam_role" {
  source                  = "../tf_modules/iam/role"
  iam_rolename            = "${var.concourse_iam_role_name}"
  assume_role_policy_name = "${var.concourse_policy_filename}"
  role_iam_policy_arn     = ["${module.concourse_instance_policy.iam_policy_arn}"]
  default_path            = "${path.cwd}/policies"
}

// Concourse Instance Policy
module "concourse_instance_policy" {
  source          = "../tf_modules/iam/policy"
  iam_policy_name = "${var.concourse_iam_role_policy}"
  default_path    = "${path.cwd}"
}

// Launch configuration for Concourse CI Server
module "concourse_lc" {
  source = "../tf_modules/compute/launch_configuration"

  lc_name_prefix      = "${var.concourse_lc_name_prefix}"
  lc_instance_type    = "${var.concourse_lc_instance_type}"
  lc_image_id         = "${lookup(var.concourse_amis, var.region)}"
  lc_security_groups  = ["${module.sg_asg_concourse.sg_id}"]
  lc_instance_profile = "${module.concourse_instance_profile.instance_profile_arn}"

  #Naming variables
  service     = "${var.concourse_lc_service}"
  project     = "${var.concourse_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.concourse_lc_role_name}"
  ext         = "${var.concourse_lc_ext}"
}

// Security Group for the Concourse ASG
module "sg_asg_concourse" {
  source        = "../tf_modules/network/security_groups"
  vpcid         = "${module.main_vpc.vpc_id}"
  sgdescription = "${var.concourse_asg_sg_description}"

  #Naming variables
  service     = "${var.concourse_asg_sg_service}"
  project     = "${var.concourse_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.concourse_asg_sg_role_name}"
  ext         = "${var.concourse_asg_ext}"

  sg_insrc_count = 1

  // Egress rules for CIDR Ranges
  sg_eg_cidr_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "${var.default_outbound_ip_range}"
    },
  ]

  // Ingress from Security Group Rules
  sg_in_sgsrc_rules = [
    {
      from_port = 8080
      to_port   = 8080
      protocol  = "tcp"
      src_sg_id = "${module.concourse_sg_elb.sg_id}"
    },
  ]

  // Ingress Rules from CIDR Range
  sg_in_cidr_rules = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"

      cidr_blocks = "${var.main_vpccidr}"
    },
    {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"

      cidr_blocks = "${var.main_vpccidr}"
    },
    {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"

      cidr_blocks = "${var.main_vpccidr}"
    },
    {
      from_port = -1
      to_port   = -1
      protocol  = "icmp"

      cidr_blocks = "${var.internal_ip_range}"
    },
  ]
}

// Concourse ELB
module "concourse_elb" {
  source = "../tf_modules/concourse_elb"

  elb_name                      = "${var.concourse_elb_name}"
  elb_subnets                   = ["${module.public_external_subnet_a.subnet_id}", "${module.public_external_subnet_b.subnet_id}"]
  elb_internal                  = "${var.concourse_elb_internal}"
  elb_cross_zone_load_balancing = "${var.concourse_elb_cross_zone_load_balancing}"
  elb_target                    = "${var.concourse_elb_target}"
  elb_security_groups           = ["${module.concourse_sg_elb.sg_id}"]

  # Connection draining
  elb_connection_draining = "${var.concourse_elb_connection_draining}"

  #Naming variables
  delimiter   = "-"
  service     = "${var.concourse_elb_service}"
  project     = "${var.concourse_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.concourse_elb_role_name}"
  ext         = "${var.concourse_elb_ext}"
}

// Concourse ELB SG
module "concourse_sg_elb" {
  source        = "../tf_modules/network/security_groups"
  vpcid         = "${module.main_vpc.vpc_id}"
  sgdescription = "${var.concourse_sg_elb_description}"

  #Naming variables
  service     = "${var.concourse_sg_service}"
  project     = "${var.concourse_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.concourse_elb_role_name}"
  ext         = "${var.concourse_elb_ext}"

  sg_insrc_count = 0

  // Egress rules from CIDR
  sg_eg_cidr_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "${var.default_outbound_ip_range}"
    }
  ]

  // Ingress rules from CIDR
  sg_in_cidr_rules = [
    {
      from_port   = 80
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = "${var.main_vpccidr}"
    },
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "${module.main_nat_eip.eip_public_ip}/32"
    },
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "${module.sec_nat_eip.eip_public_ip}/32"
    }
  ]
}

// Concourse ASG
module "concourse_asg" {
  source = "../tf_modules/compute/asg"

  #Module parameters
  asg_max_size = "${var.concourse_asg_max}"

  asg_min_size             = "${var.concourse_asg_min}"
  asg_launch_configuration = "${module.concourse_lc.lc_id}"
  asg_desired_capactiy     = "${var.concourse_asg_capacity}"

  asg_vpc_zone_identifier = ["${module.private_a.subnet_id}", "${module.private_b.subnet_id}"]

  asg_load_balancers                           = ["${module.concourse_elb.elb_id}"]
  asg_initial_lifecycle_hook_heartbeat_timeout = "${var.concourse_asg_initial_lifecycle_hook_heartbeat_timeout}"

  #Naming variables
  service     = "${var.concourse_asg_service}"
  project     = "${var.concourse_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.concourse_asg_role_name}"
  ext         = "${var.concourse_asg_ext}"
}
