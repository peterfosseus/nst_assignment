
#tfsec:ignore:AWS-0089 (LOW): Bucket has logging disabled
module "s3_alb_access_log_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.15.4"

  bucket = local.alb.bucket.access_log.name

  # acl    = "log-delivery-write"

  force_destroy = true

  # control_object_ownership = true
  # object_ownership         = "ObjectWriter"

  attach_elb_log_delivery_policy = true
  attach_lb_log_delivery_policy  = true

  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
      bucket_key_enabled = true
    }
  }

  lifecycle_rule = [
    {
      id      = "Expire in 365 Days"
      enabled = true

      expiration = {
        days = 365
      }

      noncurrent_version_expiration = {
        days = 365
      }
    }
  ]

  versioning = {
    enabled = true
  }

  # logging {
  #   target_bucket = module.s3_bucket_for_logs
  #   target_prefix = "log/"
  # }

  tags = local.alb.bucket.access_log.tags
}
