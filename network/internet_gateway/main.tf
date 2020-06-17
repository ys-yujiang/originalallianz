/* ====================================================
## Create a Internet gateway
## =================================================== */
resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.igw_vpc_id}"
  tags   = "${module.label.tags}"
}
