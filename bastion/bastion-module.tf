resource "aws_iam_role" "bastion_role" {
  count = local.create_bastion

  name               = "${local.module_prefix}-bastion-role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
      },
    ]
  })
  inline_policy {
    name   = "BastionExecutionPolicy"
    policy = jsonencode({
      Version   = "2012-10-17"
      Statement = [
        {
          Action = [
            "ec2:StartInstances",
            "ec2:StopInstances",
            "rds:StartDBInstance",
            "rds:StopDBInstance",
            "rds:DeleteDBInstance",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }

  tags = merge(local.common_tags, {
    Name = "${local.module_prefix}-bastion-role"
  })
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  count = local.create_bastion

  role = aws_iam_role.bastion_role[count.index].name
  name = "${local.module_prefix}-bastion-instance-profile"

  tags = merge(local.common_tags, {
    Name = "${local.module_prefix}-bastion-instance-profile"
  })
}

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
