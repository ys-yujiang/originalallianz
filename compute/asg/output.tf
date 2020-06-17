# ====================================
# Outputs for autoscaling group module
# ====================================*/
output "asg_id" {
  value = "${aws_autoscaling_group.asg.id}"
}