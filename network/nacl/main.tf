/* ====================================================
## Create a VPC with given CIDR
## Terraform script to create a VPC on AWS
##
## Author: Werner Brandt
## Date: Jan 22nd 2018
##
## =================================================== */

resource "aws_network_acl" "default" {
  vpc_id     = "${var.vpc_id}"
  subnet_ids = "${ var.subnet_ids }"
  tags       = "${module.label.tags}"
}

resource "aws_network_acl_rule" "default" {
  network_acl_id = "${aws_network_acl.default.id}"
  rule_number    = "${lookup(var.nacl_rules[count.index], "rule_number")}"
  egress         = "${lookup(var.nacl_rules[count.index], "egress")}"
  protocol       = "${lookup(var.nacl_rules[count.index], "protocol")}"
  rule_action    = "${lookup(var.nacl_rules[count.index], "rule_action")}"
  cidr_block     = "${lookup(var.nacl_rules[count.index], "cidr_block")}"
  from_port      = "${lookup(var.nacl_rules[count.index], "from_port")}"
  to_port        = "${lookup(var.nacl_rules[count.index], "to_port")}"
  count          = "${length(var.nacl_rules)}"
}
