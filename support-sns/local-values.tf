locals {
  module_prefix = "${var.project}-${var.env}-${var.module}"
  common_tags = {
    Project     = var.project
    Environment = var.env
    Module      = var.module
  }
}
