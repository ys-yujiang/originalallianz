output "subnet_id" {
  value = "${aws_subnet.subnet.id}"
}

output "subnet_cidr" {
  value = "${aws_subnet.subnet.cidr_block}"
}

output "subnet_az" {
  value = "${aws_subnet.subnet.availability_zone}"
}

output "subnet_vpc_id" {
  value = "${aws_subnet.subnet.vpc_id}"
}