resource "aws_eip" "eip" {
  vpc                       = "${var.eip_vpc_scope}"
  associate_with_private_ip = "${var.eip_private_ip}"
  instance                  = "${var.eip_ec2_instance_id}"
  network_interface         = "${var.eip_eip_net_interface_id}"
  tags                      = "${module.label.tags}"
}