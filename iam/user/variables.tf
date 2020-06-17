/*=====================================
## Variable definition for IAM user
## ==================================*/
variable "iam_username" {
  type = "string"
}

variable "iam_user_path" {
  type    = "string"
  default = "/"
}

variable "iam_policy_arn" {
  type    = "list"
  default = []
}
