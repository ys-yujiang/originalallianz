# Description: launch configuration for ASG
resource "aws_launch_configuration" "lc" {

  name_prefix = "${var.lc_name_prefix}"
  image_id = "${var.lc_image_id}"
  instance_type = "${var.lc_instance_type}"
  security_groups = ["${var.lc_security_groups}"]
  iam_instance_profile = "${var.lc_instance_profile}"
  associate_public_ip_address = "${var.lc_associate_public_ip_address}"
  user_data = "${var.lc_user_data}"
  key_name = "${var.lc_key_name}"
  depends_on = ["aws_efs_file_system.default", "aws_efs_mount_target.efs"]


  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_efs_file_system" "default" {
  performance_mode = "${var.efs_performance_mode}"
  encrypted        = "${var.efs_encrypted}"
  kms_key_id       = "${var.efs_kms_key_arn}"
  tags             = "${module.label.tags}"
}

resource "aws_efs_mount_target" "efs" {
  # count = "${length(var.subnets)}"
  # Workaround mistake inside efs module https://github.com/terraform-providers/terraform-provider-aws/issues/1938
  count = "2"

  file_system_id  = "${aws_efs_file_system.default.id}"
  subnet_id       = "${element(var.efs_subnets, count.index)}"
  security_groups = ["${var.efs_security_groups}"]
}

