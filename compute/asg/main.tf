/* ====================================================
## Auto Scaling Group Module
## Author: Patrick Hynes - patrick.hynes@cloudreach.com
## =================================================== */

resource "aws_autoscaling_group" "asg" {
  name                      = "${module.label.id}"
  availability_zones        = "${var.asg_availability_zones}"
  vpc_zone_identifier       = ["${var.asg_vpc_zone_identifier}"]
  max_size                  = "${var.asg_max_size}"
  min_size                  = "${var.asg_min_size}"
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "ELB"
  desired_capacity          = "${var.asg_desired_capactiy}"
  launch_configuration      = "${var.asg_launch_configuration}"
  load_balancers            = ["${var.asg_load_balancers}"]

  initial_lifecycle_hook {
    name                 = "lifecycle-${module.label.id}"
    default_result       = "${var.asg_initial_lifecycle_hook_default_result}"
    heartbeat_timeout    = "${var.asg_initial_lifecycle_hook_heartbeat_timeout}"
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
  }

  # using generated tags from naming module
  tags = ["${module.label.tag_list}"]

  #  tag {
  #    key = "Name"
  #    value = "${var.asg_name}"
  # Additional Tag can be added con caller side using  
  # tags        = "${map("propagete_at_launch", "true")}"
  #    propagate_at_launch = true
  #  }

  timeouts {
    delete = "15m"
  }
}
