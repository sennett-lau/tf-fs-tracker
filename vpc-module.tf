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
