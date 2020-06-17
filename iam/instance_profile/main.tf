#=====================
# Instance profile module
#=====================

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "${var.instance_profile_name}"
  path = "/"
  role = "${var.instance_profile_role}"
}