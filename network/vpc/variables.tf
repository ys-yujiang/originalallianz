/* ====================================================
## Variable settings for VPC
## =================================================== */

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "vpc_enable_dns_hostnames" {
  default     = true
  description = "A boolean flag to enable/disable DNS support in the VPC. Defaults true."
}

variable "vpc_enable_dns_support" {
  default = false
  description = "A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
}
