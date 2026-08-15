
locals {
  ansible = {
    tags = {
      Name = "${var.company_name}-${var.service}-${var.env_name}"
    }
  }
}
