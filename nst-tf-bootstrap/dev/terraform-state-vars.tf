
locals {
  terraform-state = {
    name = "${var.company_name}-${var.service}-${var.env_name}-terraform-state"
    tags = {
      customer    = var.company_name
      environment = var.env_name
      owner       = var.owner
      service     = var.service
      cost_center = var.cost_center
    }
  }
}
