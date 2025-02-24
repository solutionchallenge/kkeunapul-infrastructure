resource "kubernetes_namespace" "default" {
  metadata {
    name = var.GCP_GKE_DEFAULT_NAMESPACE
    annotations = {
      name = "${var.GCP_GKE_DEFAULT_NAMESPACE}-namespace"
    }
  }
}