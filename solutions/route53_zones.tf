/* ====================================================
## Register a DNS Domain in Route53 
##
## =================================================== */

/* DNS PART ZONE AND RECORDS */
/*
resource "aws_route53_zone" "main" {
  count   = "${var.DnsEnabled == "true" ? 1 : 0 }"
  name    = "${var.DnsZoneName}"
  vpc_id  = "${var.vpcid}"
  comment = "Zone managed by terraform"
  tags    = "${module.label.tags}"
}
*/

# DNS Records should be placed in the script of creating a host
#resource "aws_route53_record" "database" {
#   zone_id = "${aws_route53_zone.main.zone_id}"
#   name = "mydatabase.${var.DnsZoneName}"
#   type = "A"
#   ttl = "300"
#   records = ["${aws_instance.database.private_ip}"]
#}


/* DNS PART ZONE AND RECORDS */
resource "aws_route53_zone" "main" {
  count   = "${var.DnsEnabled == "true" ? 1 : 0 }"
  name    = "${var.AztechDnsZone}"
  vpc_id  = "${module.main_vpc.vpc_id}"
  comment = "Zone managed by terraform"
  //tags    = "${module.label.tags}"
}