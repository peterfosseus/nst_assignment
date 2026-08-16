
resource "aws_codedeploy_deployment_group" "codedeploy_deployment-group" {
  app_name              = aws_codedeploy_app.codedeploy_app.name
  deployment_group_name = local.codedeploy.deployment_group.name
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = local.codedeploy.ec2_tag_filter.key
      type  = local.codedeploy.ec2_tag_filter.type
      value = local.codedeploy.ec2_tag_filter.value
    }
  }

  # trigger_configuration {
  #   trigger_events     = ["DeploymentFailure"]
  #   trigger_name       = "example-trigger"
  #   trigger_target_arn = aws_sns_topic.example.arn
  # }

  autoscaling_groups = [module.ec2_server_a.autoscaling_group_name]
  # termination_hook_enabled = true

  auto_rollback_configuration {
    enabled = local.codedeploy.auto_rollback_configuration.enabled
    events  = [local.codedeploy.auto_rollback_configuration.events]
  }

  alarm_configuration {
    enabled = local.codedeploy.alarm_configuration.enabled
    alarms = [
      aws_cloudwatch_metric_alarm.asg_high_cpu.alarm_name
    ]
  }

  outdated_instances_strategy = local.codedeploy.outdated_instances_strategy

  depends_on = [
    aws_cloudwatch_metric_alarm.healthy_hosts,
    aws_cloudwatch_metric_alarm.asg_high_cpu
  ]
}
