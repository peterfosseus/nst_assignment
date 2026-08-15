
resource "aws_route53_record" "app" {
  zone_id = local.existing.route53.hosted_zone_id
  name    = local.route53.record.name
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
