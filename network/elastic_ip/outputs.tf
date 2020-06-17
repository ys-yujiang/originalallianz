#Contains the EIP allocation ID
output "eip_id" {
  value = "${aws_eip.eip.id}"
}

#Contains the private IP address (if in VPC).
output "eip_private_ip" {
  value = "${aws_eip.eip.private_ip}"
}

#Contains the public IP address
output "eip_public_ip" {
  value = "${aws_eip.eip.public_ip}"
}

#Contains the ID of the attached instance
output "eip_instance" {
  value = "${aws_eip.eip.instance}"
}

#Contains the ID of the attached network interface
output "eip_network_interface" {
  value = "${aws_eip.eip.network_interface}"
}