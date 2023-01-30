module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name            = "${local.module_prefix}-vpc"
  cidr            = var.vpc_cidr
  azs             = local.azs
  public_subnets  = local.subnet_cidr.public_subnet
  private_subnets = local.subnet_cidr.private_subnet

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags     = local.common_tags
  vpc_tags = local.common_tags
}

resource "aws_vpc_endpoint" "dynamodb_vpc_endpoint" {
  vpc_id          = module.vpc.vpc_id
  service_name    = "com.amazonaws.${var.aws_region}.dynamodb"
  route_table_ids = module.vpc.private_route_table_ids

  tags = merge(local.common_tags, {
    Name = "${local.module_prefix}-dynamodb-vpc-endpoint"
  })
}
