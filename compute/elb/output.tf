# Description: Outputs for ELB

# wb - error on jenkins
# * module.bastion_elb_dev.output.dns_name: Resource 'aws_elb.balancer' not found for variable 'aws_elb.balancer.dns_name'
# * module.bastion_elb_prod.output.dns_name: Resource 'aws_elb.balancer' not found for variable 'aws_elb.balancer.dns_name'
# * module.bastion_elb_prod.output.elb_id: Resource 'aws_elb.balancer' not found for variable 'aws_elb.balancer.id'
# * module.bastion_elb_dev.output.elb_id: Resource 'aws_elb.balancer' not found for variable 'aws_elb.balancer.id'

output "dns_name" {
  value = "${aws_elb.balancer.dns_name}"
}

output "elb_id" {
  value = "${aws_elb.balancer.id}"
}

output "elb_zone_id" {
  value = "${aws_elb.balancer.zone_id}"
}
