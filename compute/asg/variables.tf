/*
## Description: Variables for the ASG module
## Author : Patrick Hynes
## */

# name will be build by naming module
#variable "asg_name" {
# type = "string"
#}

variable "asg_vpc_zone_identifier" {
  type    = "list"
  default = []
}

variable "asg_load_balancers" {
  type    = "list"
  default = []
}

variable "asg_availability_zones" {
  description = "Availability zones which the ASG must span"
  type        = "list"
  default     = []
}

variable "asg_max_size" {
  default     = "1"
  description = "Maximum number of instances in ASG"
}

variable "asg_min_size" {
  default     = "1"
  description = "Minimum number of instances in ASG"
}

variable "asg_health_check_grace_period" {
  default     = "300"
  description = "Default grace period of ASG"
}

variable "asg_desired_capactiy" {
  default     = "1"
  description = "Desired capacity of ASG"
}

variable "asg_launch_configuration" {
  description = "Launch configuration of ASG"
}

#variable "asg_initial_lifecycle_hook_name" {}

variable "asg_initial_lifecycle_hook_default_result" {
  default     = "CONTINUE"
  description = "Default result of lifecycle hook initial result"
}

variable "asg_initial_lifecycle_hook_heartbeat_timeout" {}

variable "asg_lifecycle_transition" {
  default = "autoscaling:EC2_INSTANCE_LAUNCHING"
}
