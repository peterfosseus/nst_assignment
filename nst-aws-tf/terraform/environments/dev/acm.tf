
module "acm_a_us_east_1" {
  #  source  = "terraform-aws-modules/acm/aws"
  source  = "terraform-aws-modules/acm/aws"
  version = "6.3.0"

  providers = {
    aws = aws.virginia
  }

  domain_name = local.acm.domain.name.a
  subject_alternative_names = [
    "*.${local.acm.domain.name.a}"
  ]
  validation_method      = "DNS"
  create_route53_records = false # hosted in this account
  #  zone_id = local.acm.domain.zone.id
  wait_for_validation = false

  tags = local.acm.tags
}

module "acm_a_eu_west_1" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-acm.git?ref=v6.3.0"

  domain_name = local.acm.domain.name.a
  subject_alternative_names = [
    "*.${local.acm.domain.name.a}"
  ]
  validation_method      = "DNS"
  create_route53_records = false # hosted in this account
  #  zone_id = local.acm.domain.zone.id
  wait_for_validation = false

  tags = merge(
    local.acm.tags,
    local.common_tags
  )
}
