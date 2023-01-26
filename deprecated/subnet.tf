resource "aws_subnet" "private_subnet" {
  count                   = min(length(data.aws_availability_zones.azs.names), var.az_count)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr.pri_subnet[count.index]
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
}

resource "aws_subnet" "public_subnet" {
  count                   = min(length(data.aws_availability_zones.azs.names), var.az_count)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr.pub_subnet[count.index]
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true
}

