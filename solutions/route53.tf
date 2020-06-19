module "route_53_private_zone" {
  source        = "../tf_modules/network/route53"
  dns_zone_name = "${var.r53_dns_private_zone_name}"
  vpcid         = "${module.main_vpc.vpc_id}"
  dns_enable    = "true"

  #Naming variables
  service     = "${var.r53_service_name}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.r53_role_name}"
  ext         = "${var.r53_extension}"
}

module "route_53_jenkins_cname" {
  source         = "../tf_modules/network/route53"
  add_dns_record = "true"
  r53_zone_id    = "${module.route_53_private_zone.dns_zone_id}"
  record_name    = "${var.r53_record_name_jenkins}"
  record_type    = "${var.r53_record_type_jenkins}"
  alias_name     = "${module.jenkins_elb.dns_name}"
  alias_zone_id  = "${module.jenkins_elb.elb_zone_id}"

  #Naming variables
  service     = "${var.r53_service_name}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.r53_role_name}"
  ext         = "jenkins"
}

module "route_53_concourse_cname" {
  source         = "../tf_modules/network/route53"
  add_dns_record = "true"
  r53_zone_id    = "${module.route_53_private_zone.dns_zone_id}"
  record_name    = "${var.r53_record_name_concourse}"
  record_type    = "${var.r53_record_type_concourse}"
  alias_name     = "${module.concourse_elb.dns_name}"
  alias_zone_id  = "${module.concourse_elb.elb_zone_id}"

  #Naming variables
  service     = "${var.r53_service_name}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.r53_role_name}"
  ext         = "concourse"
}

module "route_53_tinyproxy_cname" {
  source         = "../tf_modules/network/route53"
  add_dns_record = "true"
  r53_zone_id    = "${module.route_53_private_zone.dns_zone_id}"
  record_name    = "${var.r53_record_name_tinyproxy}"
  record_type    = "${var.r53_record_type_tinyproxy}"
  alias_name     = "${module.tinyproxy_elb.dns_name}"
  alias_zone_id  = "${module.tinyproxy_elb.elb_zone_id}"

  #Naming variables
  service     = "${var.r53_service_name}"
  project     = "${var.infra_project_name}"
  environment = "${var.environment_name}"
  role        = "${var.r53_role_name}"
  ext         = "tinyproxy"
}
