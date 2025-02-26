resource "kubernetes_ingress_v1" "primary" {
  metadata {
    name      = "ingress-primary"
    namespace = var.GCP_GKE_DEFAULT_NAMESPACE
    annotations = {
      name                                          = "${var.GCP_GKE_DEFAULT_NAMESPACE}-ingress"
      "kubernetes.io/ingress.class"                 = "gce"
      "kubernetes.io/ingress.global-static-ip-name" = var.GCP_GKE_IP_NAME
      "kubernetes.io/ingress.allow-http"            = "false"
      "cloud.google.com/neg"                        = "{\"ingress\": true}"
      "networking.gke.io/managed-certificates"      = "${var.GCP_GKE_INGRESS_CERT}"
    }
  }
  spec {
    dynamic "rule" {
      for_each = var.GCP_GKE_INGRESS_RULE
      content {
        host = lookup(rule.value, "host", null)
        http {
          dynamic "path" {
            for_each = rule.value.http.path
            content {
              path      = path.value.path
              path_type = path.value.path_type
              backend {
                service {
                  name = path.value.backend.service.name
                  port {
                    number = path.value.backend.service.port.number
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}