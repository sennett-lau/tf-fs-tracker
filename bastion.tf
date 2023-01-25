resource "aws_iam_role" "bastion_role" {
  count              = var.create_bastion ? 1 : 0
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
    name   = "ec2costsaving"
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
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  count = var.create_bastion ? 1 : 0
  role  = aws_iam_role.bastion_role[count.index].name
}

resource "aws_security_group" "bastion_security_group" {
  count       = var.create_bastion ? 1 : 0
  vpc_id      = aws_vpc.vpc.id
  description = "Used for Bastion Host"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion_host" {
  count                  = var.create_bastion ? 1 : 0
  subnet_id              = aws_subnet.public_subnet[0].id
  ami                    = data.aws_ami.bastion_ami.id
  instance_type          = "t3.nano"
  key_name               = var.bastion_key_name
  iam_instance_profile   = aws_iam_instance_profile.bastion_instance_profile[count.index].name
  vpc_security_group_ids = [aws_security_group.bastion_security_group[count.index].id]
}
