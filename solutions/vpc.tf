/* ====================================================
## Create a new VPC
## =================================================== */

## Create VPC
module "main_vpc" {
  #VPC properties
  source                   = "../tf_modules/network/vpc"
  vpc_cidr                 = "${var.main_vpccidr}"
  vpc_enable_dns_hostnames = "${var.main_vpc_enable_hostnames}"
  vpc_enable_dns_support   = "${var.main_vpc_enable_dns_support}"

  #Naming variables
  service     = "${var.main_vpc_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.main_vpc_role}"
  ext         = "${var.main_vpc_ext}"
}

module "dhcp" {
  source = "../tf_modules/network/dhcp"
  domain_name = "${var.r53_dns_private_zone_name}"
  domain_name_servers = ["${module.prim_dns_compute.main_private_ip}", "${module.sec_dns_compute.main_private_ip}"]
  vpc_id = "${module.main_vpc.vpc_id}"
}
