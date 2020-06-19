/**
* Description: Terraform file for the Jenkins build server
* Author : Patrick Hynes - patrick.hynes@cloudreach.com
*
***/
// Jenkins IAM role
module "jenkins_iam_role" {
  source                  = "../tf_modules/iam/role"
  iam_rolename            = "${var.jenkins_iam_role_name}"
  assume_role_policy_name = "${var.jenkins_policy_filename}"
  role_iam_policy_arn     = ["${module.jenkins_instance_policy.iam_policy_arn}"]
  default_path            = "${path.cwd}/policies"
}

module "jenkins_instance_policy" {
  source          = "../tf_modules/iam/policy"
  iam_policy_name = "${var.jenkins_iam_role_policy}"
  default_path    = "${path.cwd}"
}

module "jenkins_instance_profile" {
  source                = "../tf_modules/iam/instance_profile"
  instance_profile_name = "${var.jenkins_intance_profile_name}"
  instance_profile_role = "${module.jenkins_iam_role.iam_role_name}"
}

// Jenkins SSM Document for Backup
//module "jenkins_ssm_backup" {
//  source = "../tf_modules/ssm/document"
//
//  document_name = "${var.jenkins_ssm_backup_doc_name}"
//  document_type = "${var.jenkins_ssm_backup_doc_type}"
//
//  document_content = "${file("${path.module}/jenkins_ssm/jenkins_ssm_backup.json")}"
//
//  #Naming variables
//  service     = "${var.jenkins_ssm_service}"
//  project     = "${var.jenkins_project_name}"
//  environment = "${var.environment_name}"
//  role        = "${var.jenkins_ssm_role_name}"
//  ext         = "${var.jenkins_ssm_ext}"
//}

// Jenkins EFS KMS Key
module "jenkins_efs_kms" {
  source          = "../tf_modules/kms"
  key_description = "${var.jenkins_kms_description}"

  #Naming variables
  service     = "${var.jenkins_efs_kms_service}"
  project     = "${var.jenkins_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.jenkins_efs_kms_role_name}"
  ext         = "${var.jenkins_efs_kms_ext}"
}

// Jenkins EFS SG
module "jenkins_efs_sg" {
  source        = "../tf_modules/network/security_groups"
  vpcid         = "${module.main_vpc.vpc_id}"
  sgdescription = "${var.jenkins_sg_efs_description}"

  sg_insrc_count = 1

  sg_in_sgsrc_rules = [
    {
      from_port = 2049
      to_port   = 2049
      protocol  = "tcp"
      src_sg_id = "${module.sg_jenkins.sg_id}"
    },
  ]

  #Naming variables
  service     = "${var.jenkins_efs_sg_service}"
  project     = "${var.jenkins_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.jenkins_efs_sg_role_name}"
  ext         = "${var.jenkins_efs_sg_ext}"
}

// Jenkins ELB
module "jenkins_elb" {
  source                        = "../tf_modules/jenkins_elb"
  elb_name                      = "${var.jenkins_elb_name}"
  elb_subnets                   = ["${module.public_external_subnet_a.subnet_id}", "${module.public_external_subnet_b.subnet_id}"]
  elb_internal                  = "${var.jenkins_elb_internal}"
  elb_cross_zone_load_balancing = "${var.jenkins_elb_cross_zone_load_balancing}"
  elb_target                    = "${var.jenkins_elb_target}"
  elb_security_groups           = ["${module.sg_elb_jenkins.sg_id}"]

  # Connection draining
  elb_connection_draining = "${var.jenkins_elb_connection_draining}"

  #Naming variables
  delimiter   = "-"
  service     = "${var.jenkins_elb_service}"
  project     = "${var.jenkins_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.jenkins_elb_role_name}"
  ext         = "${var.jenkins_elb_ext}"
}

// Jenkins ELB Security Group
module "sg_elb_jenkins" {
  source        = "../tf_modules/network/security_groups"
  vpcid         = "${module.main_vpc.vpc_id}"
  sgdescription = "${var.jenkins_sg_elb_description}"

  #Naming variables
  service     = "${var.jenkins_sg_service}"
  project     = "${var.jenkins_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.jenkins_elb_sg_role_name}"
  ext         = "${var.jenkins_elb_ext}"

  sg_insrc_count = 0

  sg_eg_cidr_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "${var.default_outbound_ip_range}"
    },
  ]

  sg_in_cidr_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "${var.main_vpccidr}"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "${var.main_vpccidr}"
    },
  ]
}

// Jenkins EC2 Sercurity Group
module "sg_jenkins" {
  source        = "../tf_modules/network/security_groups"
  vpcid         = "${module.main_vpc.vpc_id}"
  sgdescription = "${var.jenkins_sgdescription}"

  #Naming variables
  service     = "${var.jenkins_sg_service}"
  project     = "${var.jenkins_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.jenkins_asg_sg_role_name}"
  ext         = "${var.jenkins_asg_ext}"

  sg_insrc_count = 1

  sg_eg_cidr_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "${var.default_outbound_ip_range}"
    },
  ]

  sg_in_sgsrc_rules = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
      src_sg_id = "${module.sg_elb_jenkins.sg_id}"
    },
  ]

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

// Jenkins Autoscaling Group
module "asg_jenkins" {
  source = "../tf_modules/compute/asg"

  #Module parameters
  asg_max_size = "${var.jenkins_asg_max}"

  asg_min_size             = "${var.jenkins_asg_min}"
  asg_launch_configuration = "${module.jenkins_lc.lc_id}"
  asg_desired_capactiy     = "1"

  asg_vpc_zone_identifier                      = ["${module.private_a.subnet_id}", "${module.private_b.subnet_id}"]
  asg_load_balancers                           = ["${module.jenkins_elb.elb_id}"]
  asg_initial_lifecycle_hook_heartbeat_timeout = "${var.jenkins_asg_initial_lifecycle_hook_heartbeat_timeout}"

  #Naming variables
  service     = "${var.jenkins_vpc_service}"
  project     = "${var.jenkins_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.jenkins_asg_role_name}"
  ext         = "${var.jenkins_asg_ext}"
}

// Jenkins User Data file for Jenkins Launch configuration
data "template_file" "jenkins_user_data" {
  template = "${file("${path.module}/jenkins_userdata/user-data.tpl")}"

  vars {
    efs_dns      = "${module.jenkins_lc.efs_id}"
    aws_region   = "${var.region}"
    jenkins_home = "/var/lib/jenkins"
  }
}

// Jenkins Launch Configuration
module "jenkins_lc" {
  source              = "../tf_modules/compute/launch_configuration_with_efs"
  lc_name_prefix      = "${var.jenkins_lc_name_prefix}"
  lc_instance_type    = "${var.jenkins_lc_instance_type}"
  lc_image_id         = "${lookup(var.jenkins_amis, var.region)}"
  lc_instance_profile = "${module.jenkins_instance_profile.instance_profile_arn}"
  lc_security_groups  = ["${module.sg_jenkins.sg_id}"]
  lc_key_name         = "phynes"

  lc_user_data = "${data.template_file.jenkins_user_data.rendered}"

  efs_performance_mode = "${var.jenkins_efs_performance_mode}"
  efs_security_groups  = ["${module.jenkins_efs_sg.sg_id}"]
  efs_subnets          = ["${module.private_a.subnet_id}", "${module.private_b.subnet_id}"]
  efs_kms_key_arn      = "${module.jenkins_efs_kms.key_arn}"

  #Naming variables
  service     = "${var.jenkins_vpc_service}"
  project     = "${var.jenkins_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.jenkins_lc_role_name}"
  ext         = "${var.jenkins_lc_ext}"
}
