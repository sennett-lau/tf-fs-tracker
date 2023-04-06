resource "aws_eip" "bastion_eip" {
  count      = local.create_bastion_eip
  depends_on = [
    module.bastion_host,
    data.terraform_remote_state.vpc,
  ]

  vpc      = true
  instance = module.bastion_host[0].id

  tags = merge(local.common_tags, {
    Name = "${local.module_prefix}-bastion-eip"
  })
}
