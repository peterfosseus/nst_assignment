
#  ALB

resource "aws_security_group" "elb_security_group" {
  name_prefix = "${var.company_name}-${var.env_name_full}-alb-security-group"
  description = "Allowing Web Traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allowing port 80 Inbound from Internet"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allowing port 443 Inbound from Internet"
  }

  #tfsec:ignore:AWS-0104 (CRITICAL): Security group rule allows unrestricted egress to any IP address.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allowing All Outbound Traffic"
  }

  tags = {
    Name = "${var.company_name}-${var.env_name_full}-alb-security-group"
  }
}
