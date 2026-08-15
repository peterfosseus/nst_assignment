
resource "aws_iam_policy" "server_policy" {
  name        = local.aws_iam_policy.name
  path        = "/"
  description = "IAM policy to allow log delivery"
  policy      = data.aws_iam_policy_document.server_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.server_policy.arn
  depends_on = [aws_iam_role.role]
}

resource "aws_iam_policy" "policy_server_read_secret" {
  name        = "policy-server-read-secrets"
  description = "A policy to allow the server to read the app secrets in secrets manager"
  policy      = data.aws_iam_policy_document.server_read_secret.json
}

resource "aws_iam_role_policy_attachment" "policy_attachment_read_secret" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy_server_read_secret.arn
  depends_on = [aws_iam_role.role]
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  depends_on = [aws_iam_role.role]
}

resource "aws_iam_role_policy_attachment" "s3_policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  depends_on = [aws_iam_role.role]
}

data "aws_iam_policy_document" "server_role_policy_doc" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "server_policy_doc" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "cloudwatch:PutMetricData",
      "ec2:DescribeInstances",
      "ec2:DescribeVolumes",
      "ec2:DescribeTags",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:DescribeLogGroups",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "route53:*",
      "route53domains:*"
    ]
  }
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"]
    actions   = ["ssm:GetParameter"]
  }
}

data "aws_iam_policy_document" "server_read_secret" {
  statement {
    sid    = "SecretsManagerGetAndDescribeSecret"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = ["arn:aws:secretsmanager:*:*:secret:*"]
  }
  statement {
    sid       = "KMSDecryptKey"
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = ["arn:aws:kms:*:*:key/*"]
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:SecretARN"
      values   = ["arn:aws:secretsmanager:*:*:secret:*"]
    }
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"
      values   = ["secretsmanager.*.amazonaws.com"]
    }
  }
}
