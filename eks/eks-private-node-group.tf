# Create AWS EKS Node Group - Private
resource "aws_eks_node_group" "eks_ng_private" {
  count = local.create_eks_private_node_group

  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${local.module_prefix}-eks-ng-private"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = data.terraform_remote_state.vpc.private_subnets
  # version = var.cluster_version #(Optional: Defaults to EKS Cluster Kubernetes version)

  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  disk_size      = 20
  instance_types = ["t3.medium"]

  remote_access {
    ec2_ssh_key = "eks-terraform-key"
  }

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1
    #max_unavailable_percentage = 50    # ANY ONE TO USE
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = merge(local.common_tags, {
    Name = "${local.module_prefix}-eks-ng-private"
  })
}
