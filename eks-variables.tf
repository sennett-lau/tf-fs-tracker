variable "cluster_name" {
  description = "The name of the cluster"
  type = string
  default = "eks-cluster"
}

variable "cluster_version" {
  description = "The desired Kubernetes version for your cluster. If you do not specify a value, the latest version available in Amazon EKS is used."
  type = string
  default = "1.22"
}

variable "cluster_service_ipv4_cidr" {
  description = "The CIDR block that Kubernetes service IP addresses are assigned from. If you don't specify a CIDR block"
  type = string
  default = "172.20.0.0/16"
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "create_eks" {
  description = "Create EKS cluster"
  type = bool
  default = true
}

variable "create_eks_public_node_group" {
  description = "Create EKS node group"
  type = bool
  default = true
}

variable "create_eks_private_node_group" {
  description = "Create EKS node group"
  type = bool
  default = true
}

# EKS OIDC ROOT CA Thumbprint - valid until 2037
variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}

