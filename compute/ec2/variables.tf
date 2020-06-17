
/* ====================================================
## Variable settings for EC2 instance
## =================================================== */
variable "ec2_ami" {
  type = "string"
  description = "The AMI to use for the instance"
}

variable "ec2_availability_zone" {
  type = "string"
  description = "The AZ to start the instance in"
}

variable "ec2_ebs_optimized" {
  type = "string"
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default = false
}

variable "ec2_disable_api_termination" {
  type = "string"
  description = "If true, enables EC2 Instance Termination Protection"
  default = true
}

variable "ec2_instance_type" {
  type = "string"
  description = "he type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance"
}

variable "ec2_key_name" {
  type = "string"
  description = "The key name to use for the instance"
  default = ""
}

variable "ec2_detailed_momitoring" {
  type = "string"
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default = false
}

variable "ec2_security_groups" {
  type = "list"
  description = "A list of security group IDs to associate with. SG in VPC"
  default = []
}

variable "ec2_subnet_id" {
  type = "string"
  description = "The VPC Subnet ID to launch in"
  default = ""
}

variable "ec2_associate_public_ip_address" {
  type = "string"
  description = "Associate a public ip address with an instance in a VPC"
  default = false
}

variable "ec2_private_ip" {
  type = "string"
  description = "Private IP address to associate with the instance in a VPC"
  default = ""
}

variable "ec2_source_dest_check" {
  type = "string"
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance"
  default = true
}

variable "ec2_iam_instance_profile" {
  type = "string"
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile"
  default = ""
}

variable "ec2_volume_tags" {
  type = "map"
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  default = {}
}

variable "ec2_root_volume_type" {
  type = "string"
  description = "The type of volume. Can be standard, gp2, or io1"
  default = "standard"
}

variable "ec2_root_volume_size" {
  type = "string"
  description = "The size of the volume in gigabytes"
  default = "30"
}

variable "ec2_root_iops" {
  type = "string"
  description = "The amount of provisioned IOPS. This is only valid for volume_type of io1, and must be specified if using that type"
  default = ""
}
variable "ec2_root_vol_delete_on_termination" {
  type = "string"
  description = "Whether the volume should be destroyed on instance termination"
  default = true
}

variable "ec2_user_data" {
  type = "string"
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed"
  default = ""
}

variable "ec2_elastic_ip" {
  type = "string"
  default = ""
  description = "Allocation ID for elastic ip"
}
