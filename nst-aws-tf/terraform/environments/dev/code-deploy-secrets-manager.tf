resource "aws_kms_key" "secrets" {
  enable_key_rotation = true
}

resource "aws_secretsmanager_secret" "secret" {
  name                    = local.app.app_secret_name
  kms_key_id              = aws_kms_key.secrets.arn
  recovery_window_in_days = 0
}

# This value is read from GitLab Ci/CD vars and envsubst in the pipeline.
resource "aws_secretsmanager_secret_version" "secret" {
  secret_id = aws_secretsmanager_secret.secret.id
  secret_string = jsonencode({
    demo = "${DEV_AWS_SECRET}"
  })
}
