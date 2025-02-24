resource "kubernetes_ingress" "primary" {
  metadata {
    name      = "ingress-primary"
    namespace = var.GCP_GKE_DEFAULT_NAMESPACE
    annotations = {
      "kubernetes.io/ingress.global-static-ip-name" = var.GCP_GKE_IP_NAME
    }
  }
  spec {}
  depends_on = [google_container_cluster.primary]
}