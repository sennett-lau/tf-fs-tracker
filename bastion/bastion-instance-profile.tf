resource "aws_iam_instance_profile" "bastion_instance_profile" {
  count = local.create_bastion

  role = aws_iam_role.bastion_role[count.index].name
  name = "${local.module_prefix}-bastion-instance-profile"

  tags = merge(local.common_tags, {
    Name = "${local.module_prefix}-bastion-instance-profile"
  })
}
