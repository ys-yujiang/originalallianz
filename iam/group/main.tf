/* ====================================================
## Create a IAM Group
## =================================================== */
resource "aws_iam_group" "iam_group" {
  name = "${var.iam_group_name}"
  path = "${var.iam_group_path}"
}

resource "aws_iam_group_membership" "team" {
  name = "${var.iam_group_membership_name}"

  users = ["${ var.iam_group_users_name }"]

  group = "${aws_iam_group.iam_group.name}"
}

resource "aws_iam_group_policy_attachment" "policy_attach" {
  group      = "${aws_iam_group.iam_group.name}"
  policy_arn = "${var.group_iam_policy_arn[count.index]}"
  count      = "${var.count_attach_policy}"
}

resource "aws_iam_group_policy" "assume_role_policy_attach" {
  name  = "${var.assume_role_policy_name}"
  group = "${aws_iam_group.iam_group.id}"

  policy = "${file("${var.default_path}/${var.assume_role_policy_name}.json")}"
}
