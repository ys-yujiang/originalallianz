module "main_igw" {
  #Internet gateway definition
  source     = "../tf_modules/network/internet_gateway"
  igw_vpc_id = "${module.main_vpc.vpc_id}"

  #Naming variables
  service     = "${var.internet_gateway_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.main_igw_role}"
  ext         = "${var.main_igw_ext}"
}

module "main_nat" {
  source                = "../tf_modules/network/nat_gateway"
  nat_eip_allocation_id = "${module.main_nat_eip.eip_id}"
  nat_subnet_id         = "${module.public_external_subnet_a.subnet_id}"

  #Naming variables
  service     = "${var.nat_gateway_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.main_nat_role}"
  ext         = "${var.nat_ext}"
}

module "sec_nat" {
  source                = "../tf_modules/network/nat_gateway"
  nat_eip_allocation_id = "${module.sec_nat_eip.eip_id}"
  nat_subnet_id         = "${module.public_external_subnet_b.subnet_id}"

  #Naming variables
  service     = "${var.nat_gateway_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.sec_nat_role}"
  ext         = "${var.nat_ext}"
}
