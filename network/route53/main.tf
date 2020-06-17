/* ====================================================
## Register a DNS Domain in Route53 
##
## =================================================== */

/* Add private zone */
resource "aws_route53_zone" "private_zone" {
  count   = "${var.dns_enable == "true" ? 1 : 0 }"
  name    = "${var.dns_zone_name}"
  vpc_id  = "${var.vpcid}"
  comment = "Zone managed by terraform"
  tags    = "${module.label.tags}"
}

/* Set alias record */
resource "aws_route53_record" "alias" {
  count   = "${var.add_dns_record == "true" ? 1 : 0 }"
  zone_id =  "${element(var.r53_zone_id, 0)}"
  name    = "${var.record_name}"
  type    = "${var.record_type}"

  alias {
    name                   = "${var.alias_name}"
    zone_id                = "${var.alias_zone_id}"
    evaluate_target_health = "${var.alias_health_check}"
  }
}
