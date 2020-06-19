module "route_table_public_external" {
  source = "../tf_modules/network/route_table"
  vpc_id = "${module.main_vpc.vpc_id}"

  //gw_id     = "${module.main_igw.igw_id}"
  //gw_routes = "${var.rt_igw_routes}"
  internet_gw_id = "${module.main_igw.igw_id}"

  internet_gw_routes = "${var.rt_igw_routes}"

  virtual_gw_id     = "${var.virtual_gw_id}"
  virtual_gw_routes = "${var.rt_vgw_routes}"

  rt_propagating_vgws = ["${var.virtual_gw_id}"]

  rt_subnet_assoc_id = ["${module.public_external_subnet_a.subnet_id}",
    "${module.public_external_subnet_b.subnet_id}",
  ]

  #This param exists because terraform can't do count on calculated values
  rt_number_of_subnets = "2"

  #Naming variables
  service     = "${var.route_table_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.rt_public_external_role}"
  ext         = "01"
}

module "route_table_private_a" {
  source        = "../tf_modules/network/route_table"
  vpc_id        = "${module.main_vpc.vpc_id}"
  gw_nat_id     = "${module.main_nat.nat_id}"
  gw_nat_routes = "${var.rt_private_nat_routes}"

  virtual_gw_id     = "${var.virtual_gw_id}"
  virtual_gw_routes = "${var.rt_vgw_routes}"

  rt_propagating_vgws = ["${var.virtual_gw_id}"]


  rt_subnet_assoc_id = ["${module.private_a.subnet_id}",
    "${module.private_b.subnet_id}",
  ]

  rt_number_of_subnets = "2"

  #Naming variables
  service     = "${var.route_table_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.rt_private_role}"
  ext         = "01"
}
