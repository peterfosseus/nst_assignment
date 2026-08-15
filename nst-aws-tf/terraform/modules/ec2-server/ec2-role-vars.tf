
locals {
  aws_iam_role = {
    name = "${var.base_company_name}-${var.base_env_name}-${var.network_subnet_type}-${var.network_subnet_name}-role"
    tags = "${var.base_company_name}-${var.base_env_name}-${var.network_subnet_type}-${var.network_subnet_name}-role"
  }
}
