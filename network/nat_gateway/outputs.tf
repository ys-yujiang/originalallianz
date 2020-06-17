#The ID of the NAT Gateway
output "nat_id" {
  value = "${aws_nat_gateway.nat_gw.id}"
}

#The Allocation ID of the Elastic IP address for the gateway
output "nat_allocation_id" {
  value = "${aws_nat_gateway.nat_gw.allocation_id}"
}

#The Subnet ID of the subnet in which the NAT gateway is placed
output "nat_subnet_id" {
  value = "${aws_nat_gateway.nat_gw.subnet_id}"
}

#The ENI ID of the network interface created by the NAT gateway
output "nat_network_interface_id" {
  value = "${aws_nat_gateway.nat_gw.network_interface_id}"
}

#The private IP address of the NAT Gateway
output "nat_private_ip" {
  value = "${aws_nat_gateway.nat_gw.private_ip}"
}

#The public IP address of the NAT Gateway
output "nat_public_ip" {
  value = "${aws_nat_gateway.nat_gw.public_ip}"
}