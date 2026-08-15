
locals {
  aws_iam_instance_profile = {
    name = "${var.base_company_name}-${var.base_env_name}-${var.network_subnet_type}-${var.network_subnet_name}-profile"
  }
}
