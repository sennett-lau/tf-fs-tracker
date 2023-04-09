locals {
  module_prefix = "${var.project}-${var.env}-${var.module}"
  common_tags   = {
    Project     = var.project
    Environment = var.env
    Module      = var.module
  }

  az_count    = min(length(data.aws_availability_zones.azs.names), var.az_count)
  azs         = keys({for idx, az in data.aws_availability_zones.azs.names : az => az if idx < local.az_count})
  subnet_cidr = {
    public_subnet  = keys({for idx, cidr in var.subnet_cidr.public_subnet : cidr => cidr if idx < local.az_count})
    private_subnet = keys({for idx, cidr in var.subnet_cidr.private_subnet : cidr => cidr if idx < local.az_count})
  }
}
