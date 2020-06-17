# Description: ELB variables
variable "elb_security_groups" {
  type    = "list"
  default = []
}

# Not used get from naming module
# variable "elb_name" {}

variable "elb_internal" {}

variable "elb_subnets" {
  type    = "list"
  default = []
}

variable "elb_availability_zones" {
  description = "Availability zones which the ASG must span"
  type        = "list"
  default     = []
}

variable "elb_instance_port" {
  description = "Listen Port on ec2 instance"
  default = "8080"
}

variable "elb_instance_protocol" {
  description = "Listen protocol on ec2 instance"
  default = "http"
}

variable "elb_port" {
  description = "Listen port on ELB"
  default = "80"
}

variable "elb_protocol" {
  description = "Listen protocol on ELB"
  default = "http"
}

variable "elb_healthy_threshold" {
  default = 2
}

variable "elb_unhealthy_threshold" {
  default = 2
}

variable "elb_timeout" {
  default = 3
}

variable "elb_target" {
  type = "string"
}

variable "elb_interval" {
  default = "30"
}

variable "elb_cross_zone_load_balancing" {}

variable "elb_idle_timeout" {
  default = 300
}

variable "elb_connection_draining" {}

variable "elb_connection_draining_timeout" {
  default = 400
}
