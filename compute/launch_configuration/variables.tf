# Description: Launch Configuration variables
variable "lc_name_prefix" {
  default = "Default Launch Configuration"
}

variable "lc_security_groups" {
  type = "list"
}

variable "lc_instance_profile" {}

variable "lc_image_id" {}

variable "lc_instance_type" {}

variable "lc_associate_public_ip_address" {
  description = "Boolean to either associate public ip address or not"
  default = false
}

variable "lc_create_before_destroy" {
  default = false
}

variable "lc_user_data" {
  default = ""
}

variable "lc_key_name" {
  default = ""
}



