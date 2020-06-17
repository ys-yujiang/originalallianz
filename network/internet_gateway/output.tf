/* ====================================
## Output definition for Internet gateway
## ====================================*/

output "igw_id" {
  value = "${aws_internet_gateway.gw.id}"
}