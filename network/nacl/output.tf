/* ====================================
## Output definition of Network ACLs
##
## Author: Werner Brandt
## Date: Jan 29th 2018
##
## ====================================*/

output "nacl-mgmt-id" {
  value = "${aws_network_acl.mgmtnet.*.id}"
}

output "nacl-hosts-id" {
  value = "${aws_network_acl.hostsnet.*.id}"
}
