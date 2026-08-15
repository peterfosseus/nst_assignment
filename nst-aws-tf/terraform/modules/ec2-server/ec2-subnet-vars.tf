
locals {
  subnet = {
    cidr = {
      block = {
        a = cidrsubnet(var.vpc_cidr_block, 4, var.network_subnet_number * 2 + 4)
        b = cidrsubnet(var.vpc_cidr_block, 4, var.network_subnet_number * 2 + 5)
      }
    }
    availability = {
      zone = {
        a = "${var.base_aws_region}a"
        b = "${var.base_aws_region}b"
      }
    }
    tags = {
      a = {
        Name = "${var.base_company_name}-${var.base_env_name}-${var.network_subnet_type}-${var.ec2_server_name}-private-subnet-${var.network_subnet_number}a"
      }
      b = {
        Name = "${var.base_company_name}-${var.base_env_name}-${var.network_subnet_type}-${var.ec2_server_name}-private-subnet-${var.network_subnet_number}b"
      }
    }
  }
}
