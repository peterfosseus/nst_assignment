
# target group

resource "aws_lb_target_group" "target_group" {
  name                 = local.tg.name
  protocol             = var.ec2_server_tg_protocol
  port                 = var.ec2_server_tg_port
  target_type          = "instance"
  deregistration_delay = 10
  vpc_id               = var.vpc_id

  health_check {
    enabled             = true
    interval            = 20
    path                = var.ec2_server_tg_health_check
    port                = var.ec2_server_tg_port
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 15
    protocol            = var.ec2_server_tg_protocol
    matcher             = "200"
  }
}
