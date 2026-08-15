
module "ansible_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.15.4"

  bucket_prefix = "rewards-dev-deployment-"
  force_destroy = true

  control_object_ownership = true

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

  versioning = {
    enabled = true
  }

  tags = local.ansible.tags

  # lifecycle_rule = [
  #   {
  #     id      = "Expire in ${var.guardduty_s3_bucket_lifecycle_expiration_days} Days"
  #     enabled = true
  #
  #     expiration = {
  #       days = var.guardduty_s3_bucket_lifecycle_expiration_days
  #     }
  #
  #     noncurrent_version_expiration = {
  #       days = var.guardduty_s3_bucket_lifecycle_noncurrent_version_expiration_days
  #     }
  #
  #     filter = {
  #       prefix = ""
  #     }
  #   }
  # ]

  logging = {
    target_bucket = module.s3_alb_access_log_bucket.s3_bucket_id
    target_prefix = "log/"
    target_object_key_format = {
      partitioned_prefix = {
        partition_date_source = "DeliveryTime" # "EventTime"
      }
      # simple_prefix = {}
    }
  }
}

# resource "aws_s3_bucket" "deployment" {
#   bucket_prefix = "rewards-dev-deployment-"
#   tags          = local.ansible.tags
# }
