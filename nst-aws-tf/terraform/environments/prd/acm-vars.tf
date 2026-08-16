
locals {
  acm = {
    domain = {
      name = {
        a = "fosseus.co.za" # Wildcard cert will be *.domain.com
      }
    }
    tags = {
      Name = "${var.company_name}-acm-a"
    }
  }
}
