resource "kubernetes_storage_class_v1" "ebs_sc" {
  metadata {
    name = "ebs-sc"
  }

  provisioner         = "ebs.csi.aws.com"
  volume_binding_mode = "WaitForFirstConsumer"
}