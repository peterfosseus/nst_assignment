
locals {
  subnet = {
    number = "1"
    type   = "app"
    name   = "api"
  }
}

locals {
  server_name = "api"
  alb_endpoint = {
    a = "api"
  }
}

locals {
  ec2_server = {
    name = local.server_name
    # key_pair_name           = "${var.company_name}-${var.env_name}-${local.server_name}-key-pair"
    monitoring              = true
    ebs_optimized           = true
    disable_api_termination = true
    instance = {
      type              = "t3.medium"
      availability_zone = "eu-west-1a"
    }
    volume = {
      a = {
        size = "30"
        type = "gp3"
      }
    }
    ami = {
      image_id   = "ami-04bc53b7a499f5d37"
      image_name = "Amazon Linux 2023 AMI 2023.12.20260803.3 x86_64 HVM kernel-6.18"
    }
    alb_listener_rule = {
      a = {
        host_header = "${local.alb_endpoint.a}.${local.acm.domain.name.a}"
        priority    = 10
      }
      tags = {
        Name = "${var.company_name}-${var.env_name}-${local.subnet.type}-${local.subnet.name}-rule"
      }
    }
    asg = {
      min_size         = 1
      max_size         = 1
      desired_capacity = 1
    }
    tg = {
      protocol     = "HTTP"
      port         = 8080
      health_check = "/health"
    }
    dns = {
      host = "${var.company_name}-${var.env_name}"
    }
    code_deploy_tags = {
      app = local.codedeploy.ec2_tag_filter.value
    }
  }
}
