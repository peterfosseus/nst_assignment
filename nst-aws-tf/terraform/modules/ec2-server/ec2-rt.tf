
# route table

resource "aws_route_table" "private_route_table" {
  vpc_id     = var.vpc_id
  tags       = tomap(local.rt.tags)
  depends_on = [aws_subnet.private_a]
}

# route table associations

resource "aws_route_table_association" "private_subnet_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_route_table.id
  depends_on     = [aws_route_table.private_route_table]
}

resource "aws_route_table_association" "private_subnet_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_route_table.id
  depends_on     = [aws_route_table.private_route_table]
}
