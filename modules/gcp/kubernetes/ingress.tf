resource "kubernetes_ingress_v1" "primary" {
  metadata {
    name      = "ingress-primary"
    namespace = var.GCP_GKE_DEFAULT_NAMESPACE
    annotations = {
      name                                          = "${var.GCP_GKE_DEFAULT_NAMESPACE}-ingress"
      "kubernetes.io/ingress.global-static-ip-name" = var.GCP_GKE_IP_NAME
    }
  }
  spec {
    default_backend {
      service {
        name = "default-proxy"
        port {
          number = 80
        }
      }
    }
  }
  depends_on = [kubernetes_service_v1.proxy]
}