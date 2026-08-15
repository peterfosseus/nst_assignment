
locals {
  sg = {
    name = "${var.base_company_name}-${var.base_env_name}-${var.network_subnet_type}-${var.network_subnet_name}-private-security-group"
    tags = {
      Name = "${var.base_company_name}-${var.base_env_name}-${var.network_subnet_type}-${var.network_subnet_name}-private-security-group"
    }
  }
}
