/**
* Description: Terraform file for the DNS servers
* Author : Andre and Manuel      
*
***/

module "sg_dns" {
  source        = "../tf_modules/network/security_groups"
  vpcid         = "${module.main_vpc.vpc_id}"
  sgdescription = "${var.dns_sgdescription}"

  #Naming variables
  service     = "${var.dns_sg_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.dns_asg_role_name}"
  ext         = "${var.dns_asg_ext}"

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
      from_port = 0
      to_port   = 0
      protocol  = "-1"

      cidr_blocks = "${var.egress_cidr_openall}"
    },
  ]
}

//EIP
// EIPS configured in eip file !!

// Jenkins User Data file for Jenkins Launch configuration

data "template_file" "dns_user_data" {
  template = "${file("${path.module}/dns_userdata/user-data.tpl")}"

  vars {
    vpc_dns      = "${var.dns_vpc_dnsip}"
    onprem_domain   = "${var.dns_onprem_domain}"
    onprem_dns = "${var.dns_onprem_dnsip}"
  }
}


//Compute

module "prim_dns_compute" {
  source                          = "../tf_modules/compute/ec2"
  ec2_ami                         = "${lookup(var.ec2_ami_dns_id, var.region)}"
  ec2_availability_zone           = "${var.subnet_az_a}"
  ec2_instance_type               = "${var.dns_instance_type}"
  ec2_security_groups             = ["${module.sg_dns.sg_id}"]
  ec2_subnet_id                   = "${module.public_internal_subnet_a.subnet_id}"
  ec2_associate_public_ip_address = false
  ec2_key_name                    = "${module.sshkey.key_name}"

  ec2_user_data = "${data.template_file.dns_user_data.rendered}"
  //ec2_elastic_ip = "${module.prim_dns_eip.eip_id}"

  #Naming variables
  service     = "${var.default_ec2_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.dns_asg_role_name}"
  ext         = "01"
}

module "sec_dns_compute" {
  source                          = "../tf_modules/compute/ec2"
  ec2_ami                         = "${lookup(var.ec2_ami_dns_id, var.region)}"
  ec2_availability_zone           = "${var.subnet_az_b}"
  ec2_instance_type               = "${var.dns_instance_type}"
  ec2_security_groups             = ["${module.sg_dns.sg_id}"]
  ec2_subnet_id                   = "${module.public_internal_subnet_b.subnet_id}"
  ec2_associate_public_ip_address = false
  ec2_key_name                    = "${module.sshkey.key_name}"

  ec2_user_data = "${data.template_file.dns_user_data.rendered}"
  //ec2_elastic_ip = "${module.sec_dns_eip.eip_id}"

  #Naming variables
  service     = "${var.default_ec2_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.dns_asg_role_name}"
  ext         = "02"
}
