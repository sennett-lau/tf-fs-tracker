resource "aws_nat_gateway" "nat_gateway" {
  count         = min(length(data.aws_availability_zones.azs.names), var.az_count)
  subnet_id     = aws_subnet.public_subnet[count.index].id
  allocation_id = aws_eip.eip[count.index].id
}

resource "aws_route_table" "route_table_via_ngw" {
  count  = min(length(data.aws_availability_zones.azs.names), var.az_count)
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "route_via_ngw" {
  count                  = min(length(data.aws_availability_zones.azs.names), var.az_count)
  route_table_id         = aws_route_table.route_table_via_ngw[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[count.index].id
}

resource "aws_route_table_association" "private_subnet_route_table_association" {
  count          = min(length(data.aws_availability_zones.azs.names), var.az_count)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.route_table_via_ngw[count.index].id
}
