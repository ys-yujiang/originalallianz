/* ====================================================
## Create a User
## =================================================== */
resource "aws_iam_user" "user" {
  name = "${var.iam_username}"
  path = "${var.iam_user_path}"
}

#Default policy for each user
resource "aws_iam_user_policy_attachment" "policy_attach" {
  user       = "${aws_iam_user.user.name}"
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}
