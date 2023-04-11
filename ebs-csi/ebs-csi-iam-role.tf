resource "aws_iam_role" "ebs_csi_iam_role" {
  name = "${local.module_prefix}-ebs-csi-driver-role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Sid       = ""
        Principal = {
          Federated = "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn}"
        }
        Condition = {
          StringEquals = {
            "${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_url}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      },
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${local.module_prefix}-ebs-csi-driver-role"
  })
}

resource "aws_iam_role_policy_attachment" "ebs_csi_iam_role_policy_attachment" {
  role       = aws_iam_role.ebs_csi_iam_role.name
  policy_arn = aws_iam_policy.ebs_csi_iam_policy.arn
}
