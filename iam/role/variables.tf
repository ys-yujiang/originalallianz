/*=====================================
## Variable definition IAM Role
## ==================================*/
variable "iam_rolename" {
  type = "string"
}

variable "iam_rolepath" {
  type    = "string"
  default = "/"
}

variable "role_iam_policy_arn" {
  type = "list"
  default = []
}

variable "default_path" {
  type    = "string"
}

variable "attached_policy_count" {
  type = "string"
  default = "1"
}

variable "assume_role_policy_name" {
  type = "string"
}

