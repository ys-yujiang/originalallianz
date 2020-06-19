module "public_external_subnet_a" {
  #Subnet properties
  source                         = "../tf_modules/network/subnet"
  subnet_availability_zone       = "${var.subnet_az_a}"
  subnet_vpc_id                  = "${module.main_vpc.vpc_id}"
  subnet_cidr_block              = "${var.subnet_public_external_cidr_a}"
  subnet_map_public_ip_on_launch = true

  #Naming variables
  service     = "${var.subnet_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.public_external_subnet_role}"
  ext         = "01"
}

module "public_external_subnet_b" {
  #Subnet properties
  source                         = "../tf_modules/network/subnet"
  subnet_availability_zone       = "${var.subnet_az_b}"
  subnet_vpc_id                  = "${module.main_vpc.vpc_id}"
  subnet_cidr_block              = "${var.subnet_public_external_cidr_b}"
  subnet_map_public_ip_on_launch = true

  #Naming variables
  service     = "${var.subnet_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.public_external_subnet_role}"
  ext         = "02"
}

module "public_internal_subnet_a" {
  #Subnet properties
  source                   = "../tf_modules/network/subnet"
  subnet_availability_zone = "${var.subnet_az_a}"
  subnet_vpc_id            = "${module.main_vpc.vpc_id}"
  subnet_cidr_block        = "${var.subnet_public_internal_cidr_a}"

  #Naming variables
  service     = "${var.subnet_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.public_internal_subnet_role}"
  ext         = "01"
}

module "public_internal_subnet_b" {
  #Subnet properties
  source                   = "../tf_modules/network/subnet"
  subnet_availability_zone = "${var.subnet_az_b}"
  subnet_vpc_id            = "${module.main_vpc.vpc_id}"
  subnet_cidr_block        = "${var.subnet_public_internal_cidr_b}"

  #Naming variables
  service     = "${var.subnet_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.public_internal_subnet_role}"
  ext         = "02"
}

module "private_a" {
  #Subnet properties
  source                   = "../tf_modules/network/subnet"
  subnet_availability_zone = "${var.subnet_az_a}"
  subnet_vpc_id            = "${module.main_vpc.vpc_id}"
  subnet_cidr_block        = "${var.subnet_private_cidr_a}"

  #Naming variables
  service     = "${var.subnet_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.private_subnet_role}"
  ext         = "01"
}

module "private_b" {
  #Subnet properties
  source                   = "../tf_modules/network/subnet"
  subnet_availability_zone = "${var.subnet_az_b}"
  subnet_vpc_id            = "${module.main_vpc.vpc_id}"
  subnet_cidr_block        = "${var.subnet_private_cidr_b}"

  #Naming variables
  service     = "${var.subnet_service}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.private_subnet_role}"
  ext         = "02"
}
