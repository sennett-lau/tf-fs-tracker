resource "kubernetes_deployment_v1" "sample_app" {
  metadata {
    name      = "sample-app"
    namespace = "default"
  }
  spec {
    template {
      metadata {
        labels = {
          app = "sample-app"
        }
      }
      spec {
        volume {
          name = "sample-app-persistent-storage"
          persistent_volume_claim {
            // Do not reference the PVC resource directly
            // claim_name = kubernetes_persistent_volume_claim_v1 ....
            claim_name = "ebs-pvc"
          }
        }
        container {
          name  = "sample-app"
          image = "nginx:1.7.9"
          volume_mount {
            name       = "sample-app-persistent-storage"
            mount_path = "/usr/share/nginx/html"
          }
        }
      }
    }
  }
}