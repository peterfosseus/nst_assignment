
# Check for latest versions
# Terraform:    | URL : https://developer.hashicorp.com/terraform/install#release-information
# hashicorp/tfe | URL : https://registry.terraform.io/providers/hashicorp/tfe/latest
# hashicorp/aws | URL : https://registry.terraform.io/providers/hashicorp/aws/latest

# Check AWS pricing for most cist effective region for project
#  Use Ireland as potential employer is Europe based, and Ireland is lowest cost region in europe,

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      customer    = var.company_name
      owner       = var.owner
      environment = var.env_name
      service     = var.service
      cost_center = var.cost_center
    }
  }
}

# Used for Certificates that require this region.
provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

terraform {
  required_version = "~> 1.15.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.58.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.7.1"
    }
  }

  # using S3 backend
  backend "s3" {
    bucket       = "nst-rewards-dev-terraform-state"
    key          = "terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}
