terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "terraform-bucket-name"
    key    = "env/support-sns/terraform.tfstate"
    region = "us-west-2"

    dynamodb_table = "terraform-state-table-env-support-sns"
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = var.aws_profile
}
