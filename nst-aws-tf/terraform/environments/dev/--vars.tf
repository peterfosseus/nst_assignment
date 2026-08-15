
variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "company_name" {
  type    = string
  default = "nst"
}

# variable "company_name_full" {
#   type        = string
#   default = "neal street technologies"
# }

variable "env_name" {
  type    = string
  default = "dev"
}

variable "env_name_full" {
  type    = string
  default = "development"
}

variable "service" {
  type    = string
  default = "rewards"
}

variable "owner" {
  type    = string
  default = "candidate"
}

variable "cost_center" {
  type    = string
  default = "payments"
}

locals {
  common_tags = {
    customer    = var.company_name
    owner       = var.owner
    environment = var.env_name
    service     = var.service
    cost_center = var.cost_center
  }
}
