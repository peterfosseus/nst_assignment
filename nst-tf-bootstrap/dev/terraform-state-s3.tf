
#tfsec:ignore:AWS-0089 (LOW): Bucket has logging disabled
module "s3_terraform_state_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "5.15.4"

  bucket = local.terraform-state.name

  force_destroy = true

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

  tags = local.terraform-state.tags
}
