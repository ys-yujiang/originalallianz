output "ec2_instance_id" {
  value = "${aws_instance.ec2.id}"
}

output "main_private_ip" {
  value = "${element(aws_network_interface.prim_eni.private_ip, 0)}"
}

output "sec_private_ip" {
  value = "${element(aws_network_interface.sec_eni.private_ip, 0)}"
}

