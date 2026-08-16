
resource "aws_lb" "alb" {
  name = local.alb.name
  #tfsec:ignore:AWS-0053 (HIGH): Load balancer is exposed publicly.
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_security_group.id]
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]] #  local.vpc.public_subnets
  enable_http2       = true

  drop_invalid_header_fields = true
  enable_zonal_shift         = true

  # Needs to be false for terraform destroy to work
  # enable_deletion_protection = true

  access_logs {
    bucket  = module.s3_alb_access_log_bucket.s3_bucket_id
    prefix  = local.alb.name
    enabled = true
  }

  connection_logs {
    bucket  = module.s3_alb_connection_log_bucket.s3_bucket_id
    prefix  = local.alb.name
    enabled = true
  }

  tags = merge(
    local.alb.tags,
    local.common_tags
  )

  depends_on = [
    aws_security_group.elb_security_group,
    module.s3_alb_access_log_bucket,
    module.s3_alb_connection_log_bucket
  ]
}
