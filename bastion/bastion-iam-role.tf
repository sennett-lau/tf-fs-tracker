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
