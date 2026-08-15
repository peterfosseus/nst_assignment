
# security group

resource "aws_security_group" "private_security_group" {
  name        = local.sg.name
  description = "Allowing traffic to the Server from the ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [var.ec2_server_alb_sg_id]
    description     = "Allow port 8080 from ALB"
  }
  #tfsec:ignore:AWS-0104 (CRITICAL): Security group rule allows unrestricted egress to any IP address.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allowing All Outbound Traffic"
  }

  tags = local.sg.tags
}
