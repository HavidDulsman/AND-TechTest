resource "aws_autoscaling_group" "techTest-ASG" {
  name = "techTest-ASG"

  min_size             = 2
  desired_capacity     = 2
  max_size             = 4

  health_check_type    = "ELB"
  load_balancers= [var.elb_id]

  launch_configuration = var.launch_configuration_name
  availability_zones = [var.subnet1, var.subnet2]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity="1Minute"

  vpc_zone_identifier  = [var.subnet1, var.subnet2]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
}