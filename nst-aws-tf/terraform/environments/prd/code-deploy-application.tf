
resource "aws_codedeploy_app" "codedeploy_app" {
  name = local.codedeploy.application.name
}
