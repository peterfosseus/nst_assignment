
module "app_s3_object_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.15.4"

  bucket = local.codedeploy.s3.bucket_folder

  force_destroy = true

  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  # attach_policy = true
  # policy        = data.aws_iam_policy_document.cloudfront_c_oa_auth_bucket_policy.json

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
      id      = "transition-to-standard-ia"
      enabled = true

      filter = {}

      transition = {
        days          = 365
        storage_class = "STANDARD_IA"
      }
    }
  ]

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

  versioning = {
    enabled = true
  }
}
