data "aws_partition" "current" {}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = {
    bucket = "terraform-bucket-name"
    key    = "env/vpc/terraform.tfstate"
    region = "us-west-2"
  }
}

data "aws_ami" "bastion_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
\
