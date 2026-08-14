

Create GitLab project : ns-aws-tf
Set as private while deving
Use terrafom template as base (use a te,plate as there is no existing code to "match")
Install InteliJ IDEA as prefered IDE
Install Terrafom HCP plugin for syntax, autocomplete and help.

Copy code from a previous project

00-00-base

Provider Config

Match existing provider if present, otherwise use latest.

# Check for latest versions
# Terraform:    | URL : https://developer.hashicorp.com/terraform/install#release-information
# hashicorp/tfe | URL : https://registry.terraform.io/providers/hashicorp/tfe/latest (used for Terraform Cloud)
# hashicorp/aws | URL : https://registry.terraform.io/providers/hashicorp/aws/latest

Terraform Version: 1.15.8
terraform-provider-aws: v6.58.0

Adjust --provider.tf

Use a VPC module to speed up deployment

