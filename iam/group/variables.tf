/*=====================================
## Variable definition forIAM Group
## ==================================*/
variable "iam_group_name" {
  type = "string"
}

variable "iam_group_path" {
  type    = "string"
  default = "/"
}

variable "iam_group_users_name" {
  type    = "list"
  default = []
}

variable "group_iam_policy_arn" {
  type    = "list"
  default = []
}

variable "iam_group_membership_name" {
  type = "string"
}

variable "count_attach_policy" {
  type = "string"
  default = "1"
}

variable "default_path" {
  type = "string"
}

variable "assume_role_policy_name" {
  type = "string"
}
