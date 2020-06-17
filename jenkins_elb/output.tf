# Description: Outputs for ELB
output dns_name {
  value = "${aws_elb.jenkins.dns_name}"
}

output elb_id {
  value = "${aws_elb.jenkins.id}"
}

output "elb_zone_id" {
  value = "${aws_elb.jenkins.zone_id}"
}