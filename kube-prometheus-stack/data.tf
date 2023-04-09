data "aws_partition" "current" {}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config  = {
    bucket = "terraform-bucket-name"
    key    = "env/eks/terraform.tfstate"
    region = "us-west-2"
  }
}
