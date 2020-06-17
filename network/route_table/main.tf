# -----------------------------------------------------
# Create the routing table
# -----------------------------------------------------

resource aws_route_table "rt" {
  vpc_id           = "${var.vpc_id}"
  propagating_vgws = "${var.rt_propagating_vgws}"
  tags             = "${module.label.tags}"
}

resource "aws_route" "igw_routes" {
  route_table_id            = "${aws_route_table.rt.id}"
  destination_cidr_block    = "${var.internet_gw_routes[count.index]}"
  vpc_peering_connection_id = "${var.gw_vpc_peering_connection_id}"
  egress_only_gateway_id    = "${var.gw_egress_only_gateway_id }"
  instance_id               = "${var.gw_instance_id}"
  network_interface_id      = "${var.gw_network_interface_id}"
  gateway_id                = "${var.internet_gw_id}"
  count                     = "${length(var.internet_gw_routes)}"
  depends_on                = ["aws_route_table.rt"]
}

resource "aws_route" "vgw_routes" {
  route_table_id            = "${aws_route_table.rt.id}"
  destination_cidr_block    = "${var.virtual_gw_routes[count.index]}"
  vpc_peering_connection_id = "${var.gw_vpc_peering_connection_id}"
  egress_only_gateway_id    = "${var.gw_egress_only_gateway_id }"
  instance_id               = "${var.gw_instance_id}"
  network_interface_id      = "${var.gw_network_interface_id}"
  gateway_id                = "${var.virtual_gw_id}"
  count                     = "${length(var.virtual_gw_routes)}"
  depends_on                = ["aws_route_table.rt"]
}

resource "aws_route" "nat_routes" {
  route_table_id            = "${aws_route_table.rt.id}"
  destination_cidr_block    = "${var.gw_nat_routes[count.index]}"
  vpc_peering_connection_id = "${var.gw_vpc_peering_connection_id}"
  egress_only_gateway_id    = "${var.gw_egress_only_gateway_id }"
  instance_id               = "${var.gw_instance_id}"
  network_interface_id      = "${var.gw_network_interface_id}"
  nat_gateway_id            = "${var.gw_nat_id}"
  count                     = "${length(var.gw_nat_routes)}"
  depends_on                = ["aws_route_table.rt"]
}

resource "aws_route_table_association" "rta" {
  count          = "${var.rt_number_of_subnets}"
  subnet_id      = "${var.rt_subnet_assoc_id[count.index]}"
  route_table_id = "${aws_route_table.rt.id}"
}
