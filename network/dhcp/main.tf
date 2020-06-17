resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name          = "${var.dhcp_domain_name}"
  domain_name_servers  = "${var.dhcp_domain_name_servers}"
  ntp_servers          = "${var.dhcp_ntp_servers}"
  netbios_name_servers = "${var.dhcp_netbios_name_servers}"
  netbios_node_type    = "${var.dhcp_netbios_node_type}"
  tags                 = "${module.label.tags}"
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = "${var.dhcp_vpc_id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dhcp.id}"
}