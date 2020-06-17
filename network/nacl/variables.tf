/*=====================================
## Variable definition for Network ACLs
##
##
## Author: Werner Brandt
## Date: Jan 29th 2018
##
## ==================================*/

variable "vpc_id" {
  type = "string"
}

variable "nacl_rules" {
  type = "list"
}

variable "tagName" {
  default     = ""
  description = "Set the Tag Name"
}

variable "subnet_ids" {
  type = "list"
}
