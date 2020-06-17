/* ====================================================
## Create a IAM Role
## =================================================== */
resource "aws_iam_role" "iam_role" {
  name               = "${var.iam_rolename}"
  assume_role_policy = "${file("${var.default_path}/${var.assume_role_policy_name}.json")}"
}

resource "aws_iam_role_policy_attachment" "policy_attach" {
  role       = "${aws_iam_role.iam_role.name}"
  #Need to pass count and not use length because of terraform limitations
  #it cant count on computed values
  count      = "${var.attached_policy_count}"
  policy_arn = "${var.role_iam_policy_arn[count.index]}"
}

