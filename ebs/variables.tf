/*=====================================
## Variable definition for EBS
##
##
## Author:
## Date:
##
## ==================================*/

variable "ebs_availability_zone" {
  type = "string"
}

variable "ebs_volume_size_gb" {
  type = "string"
}

variable "encrypted" {
  default = true
}

variable "ebs_iops" {
  type = "string"
}

variable "snapshot_id" {
  type    = "string"
  default = ""
}

#Can be "standard", "gp2", "io1", "sc1" or "st1" (Default: "standard").
variable "ebs_type" {
  type    = "string"
  default = "standard"
}
