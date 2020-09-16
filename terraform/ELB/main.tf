resource "aws_elb" "techTest-ELB" {
  name = "techTest-ELB"
  security_groups = [var.SegGrp_elb_id]
  subnets = [var.subnet1, var.subnet2]
  cross_zone_load_balancing   = true

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
}