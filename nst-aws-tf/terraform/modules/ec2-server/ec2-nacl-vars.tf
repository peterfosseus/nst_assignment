
locals {
  nacl = {
    tags = "${var.base_company_name}-${var.base_env_name}-${var.ec2_server_name}-private-nacl"
  }
}
