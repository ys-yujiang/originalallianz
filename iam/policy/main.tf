/* ====================================================
## Terraform script to create a IAM policy
## =================================================== */

resource "aws_iam_policy" "policy" {
  name   = "${var.iam_policy_name}"
  path   = "${var.iam_policy_path}"
  policy = "${file("${var.default_path}/policies/${var.iam_policy_name}.json")}"
}
