resource "aws_security_group" "bastion_security_group" {
  count = local.create_bastion

  name        = "${local.module_prefix}-bastion-security-group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  description = "Used for Bastion Host"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${local.module_prefix}-bastion-security-group"
  })
}
