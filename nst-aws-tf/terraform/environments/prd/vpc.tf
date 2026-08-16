
# Latest version of VPC module: https://github.com/terraform-aws-modules/terraform-aws-vpc/releases
# Pin version to prevent unexpected updates

#tfsec:ignore:AWS-0104 (CRITICAL): Security group rule allows unrestricted egress to any IP address.
#tfsec:ignore:AWS-0105 (MEDIUM): Network ACL rule allows unrestricted ingress from any IP address.
#tfsec:ignore:AWS-0102 (CRITICAL): Network ACL rule allows access using ALL ports.
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.1"

  name = local.vpc.name
  cidr = local.vpc.vpc_cidr
  azs  = local.vpc.azs

  public_subnets  = local.vpc.subnet_cidr.public_subnets
  private_subnets = local.vpc.subnet_cidr.private_subnets

  public_subnet_names = [
    local.vpc.subnet_name.public_subnet_1.name_1, local.vpc.subnet_name.public_subnet_1.name_2
  ]

  private_subnet_names = [
    local.vpc.subnet_name.private_subnet_0.name_1, local.vpc.subnet_name.private_subnet_0.name_2
  ]

  public_route_table_tags = {
    Name = local.vpc.public_route_table_name
  }

  private_route_table_tags = {
    Name = local.vpc.private_route_table_name
  }

  public_dedicated_network_acl = true
  public_inbound_acl_rules     = local.vpc.network_acl["default_inbound"]
  public_outbound_acl_rules    = local.vpc.network_acl["default_outbound"]
  public_acl_tags              = local.vpc.network_nacl_tags.public
  public_subnet_tags           = local.vpc.subnet_tags.public

  private_dedicated_network_acl = true
  private_inbound_acl_rules     = local.vpc.network_acl["default_inbound"]
  private_outbound_acl_rules    = local.vpc.network_acl["default_outbound"]
  private_acl_tags              = local.vpc.network_nacl_tags.private
  private_subnet_tags           = local.vpc.subnet_tags.private

  # Default route/table/acl
  default_network_acl_tags = {
    Name = "do-not-use"
  }
  default_route_table_name    = "do-not-use"
  default_route_table_routes  = []
  default_network_acl_egress  = []
  default_network_acl_ingress = []

  enable_dns_hostnames = true
  enable_dns_support   = true

  # Single nat
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  nat_gateway_tags = merge(
    local.vpc.nat_gw_tags,
    local.common_tags
  )

  nat_eip_tags = merge(
    local.vpc.nat_gw_tags,
    local.common_tags
  )

  # Internet Gateway
  igw_tags = merge(
    local.vpc.i_gw_tags,
    local.common_tags
  )

  enable_flow_log = true

  # VPC Flow Logs to CloudWatch is the default
  # (Cloudwatch log group and IAM role will be created)
  create_flow_log_cloudwatch_log_group            = true
  create_flow_log_cloudwatch_iam_role             = true
  flow_log_max_aggregation_interval               = 60
  vpc_flow_log_tags                               = local.vpc_prod_flow_log.cloudwatch.tags
  flow_log_cloudwatch_log_group_retention_in_days = 7

  # VPC Flow Logs to S3 needs to be specified, warning the VPC module can only do one log type at a time.
  # if you need both CW and S3 logging then please enable vpc-flow-logs-s3.tf and vpc-s3.tf
  # (S3 bucket will NOT be created by this module, and must exist)
  #  flow_log_destination_type = "s3"
  #  flow_log_destination_arn  = module.s3_bucket.s3_bucket_arn
  #  vpc_flow_log_tags = local.vpc_prod_flow_log.s3.tags

  tags = merge(
    local.vpc.vpc_tags,
    local.common_tags
  )
}
