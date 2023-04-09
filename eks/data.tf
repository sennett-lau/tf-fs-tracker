data "aws_partition" "current" {}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = {
    bucket = "terraform-bucket-name"
    key    = "env/vpc/terraform.tfstate"
    region = "us-west-2"
  }
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = aws_eks_cluster.eks_cluster.name
}
