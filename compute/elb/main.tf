#==========================
# Description: ELB module
#==========================

resource "aws_elb" "balancer" {
  name            = "${module.label.id}"
  subnets         = ["${var.elb_subnets}"]
  internal        = "${var.elb_internal}"
  security_groups = ["${var.elb_security_groups}"]

  health_check {
    healthy_threshold   = "${var.elb_healthy_threshold}"
    unhealthy_threshold = "${var.elb_unhealthy_threshold}"
    timeout             = "${var.elb_timeout}"
    target              = "${var.elb_target}"
    interval            = "${var.elb_interval}"
  }

  listener {
    instance_port     = "${var.elb_instance_port}"
    instance_protocol = "${var.elb_instance_protocol}"
    lb_port           = "${var.elb_port}"
    lb_protocol       = "${var.elb_protocol}"
  }

  cross_zone_load_balancing   = "${var.elb_cross_zone_load_balancing}"
  idle_timeout                = "${var.elb_idle_timeout}"
  connection_draining         = "${var.elb_connection_draining}"
  connection_draining_timeout = "${var.elb_connection_draining_timeout}"

  tags = "${module.label.tags}"
}
