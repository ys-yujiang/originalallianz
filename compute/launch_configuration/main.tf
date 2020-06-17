resource "aws_launch_configuration" "lc" {

  name_prefix = "${var.lc_name_prefix}"
  image_id = "${var.lc_image_id}"
  instance_type = "${var.lc_instance_type}"
  security_groups = ["${var.lc_security_groups}"]
  iam_instance_profile = "${var.lc_instance_profile}"
  associate_public_ip_address = "${var.lc_associate_public_ip_address}"
  user_data = "${var.lc_user_data}"
  key_name = "${var.lc_key_name}"


  lifecycle {
    create_before_destroy = false
  }
}