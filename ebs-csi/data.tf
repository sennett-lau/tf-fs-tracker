data "aws_partition" "current" {}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config  = {
    bucket = "terraform-bucket-name"
    key    = "env/eks/terraform.tfstate"
    region = "us-west-2"
  }
}


data "http" "ebs_csi_iam_policy_data" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/master/docs/example-iam-policy.json"

  request_headers = {
    Accept = "application/json"
  }
}
