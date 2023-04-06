module "bastion_host" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"

  count                  = local.create_bastion
  name                   = "${local.module_prefix}-bastion-host"
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnets[0]
  ami                    = data.aws_ami.bastion_ami.id
  instance_type          = var.bastion_instance_type
  key_name               = var.bastion_key_name
  iam_instance_profile   = aws_iam_instance_profile.bastion_instance_profile[count.index].name
  vpc_security_group_ids = [aws_security_group.bastion_security_group[count.index].id]

  tags = merge(local.common_tags, {
    Name = "${local.module_prefix}-bastion-host"
  })
}
