
resource "aws_iam_role" "role" {
  name               = local.aws_iam_role.name #var.ec2_server_aws_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.server_role_policy_doc.json
  tags = {
    Name = local.aws_iam_role.tags #var.ec2_server_aws_iam_role_name
  }
}
