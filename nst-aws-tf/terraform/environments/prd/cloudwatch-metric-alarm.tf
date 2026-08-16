
resource "aws_cloudwatch_metric_alarm" "healthy_hosts" {
  alarm_name          = "rewards-dev-no-healthy-hosts"
  namespace           = "AWS/ApplicationELB"
  metric_name         = "HealthyHostCount"
  comparison_operator = "LessThanThreshold"
  threshold           = 1
  evaluation_periods  = 2
  period              = 60
  statistic           = "Minimum"
  treat_missing_data  = "breaching"

  dimensions = {
    LoadBalancer = aws_lb.alb.arn_suffix
    TargetGroup  = module.ec2_server_a.target_group_arn_suffix
  }
}

resource "aws_cloudwatch_metric_alarm" "asg_high_cpu" {
  alarm_name          = "${module.ec2_server_a.asg_name}-high-cpu"
  alarm_description   = "ASG average CPU is too high"
  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 3
  period             = 60
  threshold          = 80

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"
  statistic   = "Average"

  dimensions = {
    AutoScalingGroupName = module.ec2_server_a.asg_name #aws_autoscaling_group.app.name
  }

  treat_missing_data = "notBreaching"

}