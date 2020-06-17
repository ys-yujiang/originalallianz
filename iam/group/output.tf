/* ====================================
## Output definition for IAM Group
## ====================================*/
output "iam_group_arn" {
  value = "${aws_iam_group.iam_group.arn}"
}

output "iam_group_name" {
  value = "${aws_iam_group.iam_group.name}"
}

output "iam_group_path" {
  value = "${aws_iam_group.iam_group.path}"
}
