/* ====================================
## Output definition for Internet gateway
##
## Author:
## Date:
##
## ====================================*/
output "iam_user_arn" {
  value = "${ aws_iam_user.user.arn }"
}

output "iam_username" {
  value = "${ aws_iam_user.user.name }"
}
