
resource "aws_route" "private_subnet_nat_route_a" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.vpc_nat_gw
}
