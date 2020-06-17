# Description: Outputs for ELB
output dns_name {
  value = "${aws_elb.concourse.dns_name}"
}

output elb_id {
  value = "${aws_elb.concourse.id}"
}

output "elb_zone_id" {
  value = "${aws_elb.concourse.zone_id}"
}