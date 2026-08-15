
locals {
  route53 = {
    record = {
      name = "api.${local.acm.domain.name.a}"
    }
  }
}
