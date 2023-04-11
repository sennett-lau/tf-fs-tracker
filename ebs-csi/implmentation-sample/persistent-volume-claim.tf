resource "kubernetes_persistent_volume_claim_v1" "ebs_pvc" {
  metadata {
    name = "ebs-pvc"
  }
  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = kubernetes_storage_class_v1.ebs_sc.metadata.0.name
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}