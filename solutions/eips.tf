module "main_nat_eip" {
  #EIP configuration
  source        = "../tf_modules/network/elastic_ip"
  eip_vpc_scope = "${var.nat_eip_vpc_scope}"

  #Naming variables
  service     = "${var.elastic_ip_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.nat_eip_role}"
  ext         = "${var.main_nat_eip_ext}"
}

module "sec_nat_eip" {
  #EIP configuration
  source        = "../tf_modules/network/elastic_ip"
  eip_vpc_scope = "${var.nat_eip_vpc_scope}"

  #Naming variables
  service     = "${var.elastic_ip_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.nat_eip_role}"
  ext         = "${var.sec_nat_eip_ext}"
}