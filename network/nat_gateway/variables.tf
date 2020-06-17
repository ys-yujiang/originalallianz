variable "nat_eip_allocation_id" {
  type = "string"
  description = "The Allocation ID of the Elastic IP address for the gateway."
}

variable "nat_subnet_id" {
  type = "string"
  description = "The Subnet ID of the subnet in which to place the gateway"
}