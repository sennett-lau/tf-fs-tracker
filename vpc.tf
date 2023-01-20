resource "aws_vpc" "vpc" {
  cidr_block           = "10.60.14.0/23"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_vpc_endpoint" "dynamodb_vpc_endpoint" {
  vpc_id          = aws_vpc.vpc.id
  service_name    = "com.amazonaws.${data.aws_region.current.name}.dynamodb"
  route_table_ids = aws_route_table.route_table_via_ngw[*].id
}
