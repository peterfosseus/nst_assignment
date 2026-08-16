
resource "aws_lb_listener_rule" "ec2_rule_a" {
  listener_arn = aws_alb_listener.https_listener.arn
  priority     = local.ec2_server.alb_listener_rule.a.priority

  action {
    type = "forward"
    forward {
      target_group {
        arn = module.ec2_server_a.target_group_arn
      }

      stickiness {
        enabled  = true
        duration = 600
      }
    }
  }

  condition {
    host_header {
      values = [local.ec2_server.alb_listener_rule.a.host_header]
    }
  }

  tags = {
    Name = local.ec2_server.alb_listener_rule.tags.Name
  }
}
