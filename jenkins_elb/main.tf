#==========================
# Description: ELB module
#==========================

resource "aws_elb" "jenkins" {
  name            = "${var.elb_name}"
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
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  cross_zone_load_balancing   = "${var.elb_cross_zone_load_balancing}"
  idle_timeout                = "${var.elb_idle_timeout}"
  connection_draining         = "${var.elb_connection_draining}"
  connection_draining_timeout = "${var.elb_connection_draining_timeout}"

  tags = "${module.label.tags}"
}
