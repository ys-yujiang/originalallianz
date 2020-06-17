/* ====================================
## Output definition for IAM policy
## ====================================*/
output "iam_policy_arn" {
  value = "${aws_iam_policy.policy.arn}"
}

output "iam_policy_id" {
  value = "${aws_iam_policy.policy.id}"
}

output "iam_policy_name" {
  value = "${aws_iam_policy.policy.name}"
}

output "iam_policy_path" {
  value = "${aws_iam_policy.policy.path}"
}

output "iam_policy_doc" {
  value = "${aws_iam_policy.policy.policy}"
}
