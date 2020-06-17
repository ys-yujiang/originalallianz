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

variable "efs_performance_mode" {
  type        = "string"
  description = "performance mode: generalPurpose or maxIO"
  default     = "generalPurpose"
}

variable "efs_encrypted" {
  type        = "string"
  description = "encytion, should ALWAYS be enabled"
  default     = "true"
}

variable "efs_kms_key_arn" {
  type        = "string"
  description = "ARN for the KMS encryption key"
  default     = ""
}

variable "efs_subnets" {
  type = "list"
  description = "(Required) A comma separated list of subnet ids where mount targets will be."
}

variable "efs_security_groups" {
  type = "list"
}


