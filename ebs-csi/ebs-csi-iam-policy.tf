resource "aws_iam_policy" "ebs_csi_iam_policy" {
  name        = "${local.module_prefix}-AmazonEKSEBSCSIDriverPolicy"
  description = "EBS CSI Driver IAM Policy"
  path        = "/"
  policy      = data.http.ebs_csi_iam_policy_data.body

  tags = merge(local.common_tags, {
    Name = "${local.module_prefix}-AmazonEKSEBSCSIDriverPolicy"
  })
}
