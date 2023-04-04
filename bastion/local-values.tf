locals {
  module_prefix = "${var.project}-${var.env}-${var.module}"
  common_tags   = {
    Project     = var.project
    Environment = var.env
    Module      = var.module
  }
  create_bastion     = var.create_bastion ? 1 : 0
  create_bastion_eip = var.create_bastion_eip && var.create_bastion ? 1 : 0
}
