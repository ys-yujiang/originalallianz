/* ====================================================
## Create a EC2 instance
## =================================================== */
resource "aws_instance" "ec2" {
  ami                     = "${var.ec2_ami}"
  availability_zone       = "${var.ec2_availability_zone}"
  ebs_optimized           = "${var.ec2_ebs_optimized}"
  disable_api_termination = "${var.ec2_disable_api_termination}"
  instance_type           = "${var.ec2_instance_type}"
  key_name                = "${var.ec2_key_name}"
  monitoring              = "${var.ec2_detailed_momitoring}"
  user_data               = "${var.ec2_user_data}"
  iam_instance_profile    = "${var.ec2_iam_instance_profile}"
  volume_tags             = "${var.ec2_volume_tags}"

  network_interface {
    network_interface_id = "${aws_network_interface.prim_eni.id}"
    device_index         = 0
  }

  network_interface {
    network_interface_id = "${aws_network_interface.sec_eni.id}"
    device_index         = 1
  }

  root_block_device = {
    volume_type           = "${var.ec2_root_volume_type}"
    volume_size           = "${var.ec2_root_volume_size}"
    delete_on_termination = "${var.ec2_root_vol_delete_on_termination}"
  }

  tags = "${module.label.tags}"
}

resource "aws_network_interface" "prim_eni" {
  subnet_id         = "${var.ec2_subnet_id}"
  security_groups   = ["${var.ec2_security_groups}"]
  source_dest_check = "${var.ec2_source_dest_check}"
  tags              = "${module.label.tags}"
}

resource "aws_network_interface" "sec_eni" {
  subnet_id         = "${var.ec2_subnet_id}"
  security_groups   = ["${var.ec2_security_groups}"]
  source_dest_check = "${var.ec2_source_dest_check}"
  tags              = "${module.label.tags}"
}
