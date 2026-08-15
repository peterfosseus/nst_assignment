
# server nacl

resource "aws_network_acl" "nacl_private" {
  vpc_id = var.vpc_id
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]
  tags = {
    Name = local.nacl.tags
  }
  depends_on = [
    aws_subnet.private_a,
    aws_subnet.private_b
  ]
}
