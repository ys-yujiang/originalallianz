variable "vpc_id" {
  type = "string"
  description = "The VPC ID"
}

variable "internet_gw_id" {
  type = "string"
  description = "An ID of a VPC internet gateway"
  default = ""
}

variable "internet_gw_routes" {
  type = "list"
  description = "The destination CIDR block"
  default = []
}

variable "virtual_gw_id" {
  type = "string"
  description = "An ID of a VPC virtual gateway"
  default = ""
}

variable "virtual_gw_routes" {
  type = "list"
  description = "The destination CIDR block"
  default = []
}

variable "gw_nat_id" {
  type = "string"
  description = " An ID of a VPC NAT gateway"
  default = ""
}

variable "gw_nat_routes" {
  type = "list"
  description = "The destination CIDR block"
  default = []
}

variable "rt_propagating_vgws" {
  type = "list"
  description = "A list of virtual gateways for propagation"
  default = []
}

variable "gw_vpc_peering_connection_id" {
  type = "string"
  default = ""
  description = " An ID of a VPC peering connection"
}

variable "gw_egress_only_gateway_id" {
  type = "string"
  default = ""
  description = "An ID of a VPC Egress Only Internet Gateway"
}

variable "gw_instance_id" {
  type = "string"
  description = "An ID of an EC2 instance"
  default = ""
}

variable "gw_network_interface_id" {
  type = "string"
  description = " An ID of a network interface"
  default = ""
}

variable "rt_subnet_assoc_id" {
  type = "list"
  description = "Subnet id with who assocciate gateway"
  default = []
}

variable "rt_number_of_subnets" {
  type = "string"
  description = "Number of subnets to associate with route table. This param because of terraform limits"
}

