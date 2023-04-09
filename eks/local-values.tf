locals {
  module_prefix = "${var.project}-${var.env}-${var.module}"
  common_tags = {
    Project     = var.project
    Environment = var.env
    Module      = var.module
  }

  create_eks_public_node_group = var.create_eks_public_node_group ? 1 : 0
  create_eks_private_node_group = var.create_eks_private_node_group ? 1 : 0
}
