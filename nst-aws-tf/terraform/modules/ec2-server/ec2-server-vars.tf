
locals {
  ec2_server = {
    name = "${var.base_company_name}-${var.base_env_name}-${var.ec2_server_name}"
    volume = {
      tags = {
        Name = "${var.base_company_name}-${var.base_env_name}-${var.ec2_server_name}"
        env  = "backup"
      }
    }
    tags = {
      Name          = "${var.base_company_name}-${var.base_env_name}-${var.base_service}-${var.ec2_server_name}"
      configuration = "rewards-dev"
    }
  }
}
