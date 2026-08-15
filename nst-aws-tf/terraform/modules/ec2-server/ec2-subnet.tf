
# EC2 server - subnet

resource "aws_subnet" "private_a" {
  vpc_id                  = var.vpc_id
  cidr_block              = local.subnet.cidr.block.a
  map_public_ip_on_launch = "false"
  availability_zone       = local.subnet.availability.zone.a #var.ec2_server_subnet_availability_zone_a
  tags                    = local.subnet.tags.a
}

resource "aws_subnet" "private_b" {
  vpc_id                  = var.vpc_id
  cidr_block              = local.subnet.cidr.block.b
  map_public_ip_on_launch = "false"
  availability_zone       = local.subnet.availability.zone.b
  tags                    = local.subnet.tags.b
}
