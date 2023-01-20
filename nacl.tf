resource "aws_network_acl" "network_acl" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_network_acl_rule" "inbound_network_acl_rule" {
  network_acl_id = aws_network_acl.network_acl.id
  rule_number    = 100
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  egress         = false
}

resource "aws_network_acl_rule" "outbound_network_acl_rule" {
  network_acl_id = aws_network_acl.network_acl.id
  rule_number    = 100
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  egress         = true
}

resource "aws_network_acl_association" "public_subnet_network_acl_association" {
  count          = var.az_count
  network_acl_id = aws_network_acl.network_acl.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

resource "aws_network_acl_association" "private_subnet_network_acl_association" {
  count          = var.az_count
  network_acl_id = aws_network_acl.network_acl.id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}
