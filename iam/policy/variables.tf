/*=====================================
## Variable definition for IAM policy
## ==================================*/
variable "iam_policy_name" {
  type = "string"
}

variable "iam_policy_path" {
  type    = "string"
  default = "/"
}

variable "default_path" {
  type = "string"
}
