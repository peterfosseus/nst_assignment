
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  depends_on = [
    aws_lb.alb
  ]
}

resource "aws_alb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = module.acm_a_eu_west_1.acm_certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "NOT FOUND : Requested page not found."
      status_code  = "404"
    }
  }
  depends_on = [
    aws_lb.alb
  ]
}
