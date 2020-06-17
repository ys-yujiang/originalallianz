/* ====================================
## Output definition for EBS
##
## Author:
## Date:
##
## ====================================*/
output "ebs_id" {
  value = "${aws_ebs_volume.volume.id}"
}

output "ebs_arn" {
  value = "${aws_ebs_volume.volume.arn}"
}
