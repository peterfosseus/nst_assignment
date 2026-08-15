
# Check for latest versions
# Terraform:    | URL : https://developer.hashicorp.com/terraform/install#release-information
# hashicorp/tfe | URL : https://registry.terraform.io/providers/hashicorp/tfe/latest
# hashicorp/aws | URL : https://registry.terraform.io/providers/hashicorp/aws/latest

# Check AWS pricing for most cist effective region for project
#  Use Ireland as potential employer is Europe based, and Ireland is lowest cost region in europe,

provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_version = "~> 1.15.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.58.0"
    }
  }

  # using GitLab http backend
  backend "http" {
  }
}
