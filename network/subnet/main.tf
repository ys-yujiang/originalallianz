resource "aws_subnet" "subnet" {
  availability_zone       = "${var.subnet_availability_zone}"
  cidr_block              = "${var.subnet_cidr_block}"
  map_public_ip_on_launch = "${var.subnet_map_public_ip_on_launch}"
  vpc_id                  = "${var.subnet_vpc_id}"
  tags                    = "${module.label.tags}"
}
