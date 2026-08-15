
locals {
  rt = {
    tags = {
      Name = "${var.base_company_name}-${var.base_env_name}-${var.ec2_server_name}-private-route-table"
    }
  }
}
