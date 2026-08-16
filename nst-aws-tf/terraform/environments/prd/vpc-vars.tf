
# For CIDR help see : https://cidrsubnet.com/cidrsubnet.html
# CIDR selected is a /22 allowing enough IP's for subnets, without wasting address space.


data "aws_availability_zones" "available" {}

locals {
  vpc = {
    name     = "${var.company_name}-${var.service}-${var.env_name}"
    vpc_cidr = "10.10.0.0/16"
    azs      = slice(data.aws_availability_zones.available.names, 0, 2)

    subnet_cidr = {
      public_subnets = [
        "10.10.1.0/24", "10.10.2.0/24"
      ]
      private_subnets = [
        # Used for nat
        "10.10.3.0/24", "10.10.4.0/24"
      ]
    }

    subnet_name = {
      public_subnet_1 = {
        name_1 = "${var.company_name}-${var.env_name}-public-subnet-1a"
        name_2 = "${var.company_name}-${var.env_name}-public-subnet-1b"
      }
      # Used for nat gateway
      private_subnet_0 = {
        name_1 = "${var.company_name}-${var.env_name}-private-subnet-1a"
        name_2 = "${var.company_name}-${var.env_name}-private-subnet-1b"
      }
    }

    public_route_table_name  = "${var.company_name}-${var.env_name}-public-route-table"
    private_route_table_name = "${var.company_name}-${var.env_name}-private-route-table"

    vpc_tags = {
      Name = "${var.company_name}-${var.service}-${var.env_name}"
    }

    subnet_tags = {
      public = {
        Name = "${var.company_name}-${var.env_name}-public-subnet"
      }
      private = {
        Name = "${var.company_name}-${var.env_name}-nat-gateway-subnet"
      }
    }

    network_nacl_tags = {
      public = {
        Name = "${var.company_name}-${var.env_name}-public-nacl"
      }
      private = {
        Name = "${var.company_name}-${var.env_name}-private-nacl"
      }
    }

    i_gw_tags = {
      Name = "${var.company_name}-${var.env_name}-internet-gateway"
    }

    nat_gw_tags = {
      Name = "${var.company_name}-${var.env_name}-nat-gateway"
    }

    network_acl = {
      default_inbound = [
        {
          rule_number = 100
          rule_action = "allow"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_block  = "0.0.0.0/0"
        }
      ]
      default_outbound = [
        {
          rule_number = 100
          rule_action = "allow"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_block  = "0.0.0.0/0"
        }
      ]
    }
  }

  vpc_prod_flow_log = {
    cloudwatch = {
      tags = {
        # Name        = "${var.company_name}-${var.env_name}-flow-log-cloudwatch"
        customer    = var.company_name
        environment = var.env_name
        service     = var.service
        cost_center = var.cost_center
      }
    }

    # s3 = {
    #   log_bucket_name = "${var.company_name}-${var.env_name}-flow-log"
    #   tags = {
    #     Name        = "${var.company_name}-${var.env_name}-flow-log-s3"
    #     Customer    = var.company_name
    #     Environment = var.env_name
    #   }
    # }
  }
}
