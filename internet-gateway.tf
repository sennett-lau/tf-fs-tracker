resource "aws_internet_gateway" "internet_gateway" {}

resource "aws_internet_gateway_attachment" "attach_gateway" {
  internet_gateway_id = aws_internet_gateway.internet_gateway.id
  vpc_id              = aws_vpc.vpc.id
}

resource "aws_route_table" "route_via_igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "public_route_via_igw" {
  route_table_id         = aws_route_table.route_via_igw.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_subnet_route_table_association" {
  count          = min(length(data.aws_availability_zones.azs.names), var.az_count)
  route_table_id = aws_route_table.route_via_igw.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}
