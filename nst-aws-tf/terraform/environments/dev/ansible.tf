
data "archive_file" "ansible" {
  type        = "zip"
  source_dir  = "${path.module}./../../ansible"
  output_path = "${path.module}/ansible.zip"
}

resource "aws_s3_object" "ansible" {
  bucket      = module.ansible_bucket.s3_bucket_id
  key         = "ansible/${data.archive_file.ansible.output_md5}.zip"
  source      = data.archive_file.ansible.output_path
  source_hash = data.archive_file.ansible.output_md5
}

resource "aws_ssm_association" "rewards" {
  name             = "AWS-ApplyAnsiblePlaybooks"
  association_name = "rewards-dev-configuration"

  targets {
    key    = "tag:configuration"
    values = ["rewards-dev"]
  }

  parameters = {
    SourceType = "S3"
    SourceInfo = jsonencode({
      path = "https://${module.ansible_bucket.s3_bucket_id}.s3.${var.aws_region}.amazonaws.com/${aws_s3_object.ansible.key}"
    })
    InstallDependencies = "True"
    PlaybookFile        = "site.yml"
    # ExtraVariables      = "environment=dev aws_region=${var.aws_region}"
    Check          = "False"
    Verbose        = "-vvvv"
    TimeoutSeconds = "3600"
  }

  apply_only_at_cron_interval = false
}
