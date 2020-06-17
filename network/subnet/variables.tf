variable "subnet_availability_zone" {
  type        = "string"
  description = "The AZ for the subnet. e.g. eu-west-1a"
}

variable "subnet_vpc_id" {
  type        = "string"
  description = "VPC ID"
}

variable "subnet_cidr_block" {
  type        = "string"
  description = "Cidr block that you want to assign to subnet in AZ (e.g. 10.20.0.0/24)"
}

variable "subnet_map_public_ip_on_launch" {
  type = "string"
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP"
  default = false
}
