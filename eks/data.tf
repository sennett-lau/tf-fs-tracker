data "aws_partition" "current" {}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = {
    bucket = "terraform-bucket-name"
    key    = "env/vpc/terraform.tfstate"
    region = "us-west-2"
  }
}
