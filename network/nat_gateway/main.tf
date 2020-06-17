resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${var.nat_eip_allocation_id}"
  subnet_id     = "${var.nat_subnet_id}"
  tags          = "${module.label.tags}"
}