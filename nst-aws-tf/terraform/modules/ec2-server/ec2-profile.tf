
resource "aws_iam_instance_profile" "profile" {
  name       = local.aws_iam_instance_profile.name #  var.ec2_server_aws_iam_instance_profile_name
  role       = aws_iam_role.role.name
  depends_on = [aws_iam_role.role]
}
