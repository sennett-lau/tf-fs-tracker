resource "helm_release" "kube_prometheus_stack" {
  name  = "${local.module_prefix}-kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart = "kube-prometheus-stack"
  namespace = "${var.namespace}"

  set {
    name  = "alertmanager.persistentVolume.storageClass"
    value = "gp2"
  }

  set {
    name  = "server.persistentVolume.storageClass"
    value = "gp2"
  }

  tags     = merge(local.common_tags, {
    Name = "${local.module_prefix}-kube-prometheus-stack"
  })
}
