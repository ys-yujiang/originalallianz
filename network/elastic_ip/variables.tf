variable "eip_vpc_scope" {
  type = "string"
  description = "Boolean if the EIP is in a VPC or not"
}

variable "eip_private_ip" {
  type = "string"
  description = "A user specified primary or secondary private IP address to associate with the Elastic IP address.If no private IP address is specified, the Elastic IP address is associated with the primary private IP address"
  default = ""
}

variable "eip_ec2_instance_id" {
  type = "string"
  description = "EC2 instance ID"
  default = ""
}

variable "eip_eip_net_interface_id" {
  type = "string"
  description = "Network interface ID to associate with"
  default = ""
}