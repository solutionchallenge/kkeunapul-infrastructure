locals {
  backend_service_timeouts = {
    for service in flatten([
      for rule in var.GCP_GKE_INGRESS_RULE : [
        for path in rule.http.path : {
          name    = path.backend.service.name
          timeout = path.backend.service.timeout
        }
      ]
    ]) : service.name => service.timeout
  }
  backend_config_annotation_map = {
    for service_name in keys(local.backend_service_timeouts) :
    service_name => "${var.GCP_PROJECT_ID}-backend-config-${service_name}"
  }
}

resource "google_compute_ssl_policy" "primary" {
  name            = "${var.GCP_PROJECT_ID}-ssl-policy"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}

resource "kubernetes_manifest" "certificate" {
  manifest = {
    apiVersion = "networking.gke.io/v1"
    kind       = "ManagedCertificate"
    metadata = {
      name      = "${var.GCP_PROJECT_ID}-ssl-certificate"
      namespace = var.GCP_GKE_DEFAULT_NAMESPACE
    }
    spec = {
      domains = ["${var.GCP_GKE_SSL_DOMAIN}"]
    }
  }
}

resource "kubernetes_manifest" "frontend" {
  manifest = {
    apiVersion = "networking.gke.io/v1beta1"
    kind       = "FrontendConfig"
    metadata = {
      name      = "${var.GCP_PROJECT_ID}-ingress-frontend"
      namespace = var.GCP_GKE_DEFAULT_NAMESPACE
    }
    spec = {
      sslPolicy = google_compute_ssl_policy.primary.name
      redirectToHttps = {
        enabled          = true
        responseCodeName = "MOVED_PERMANENTLY_DEFAULT"
      }
    }
  }
}

resource "kubernetes_manifest" "backend_config" {
  for_each = local.backend_service_timeouts

  manifest = {
    apiVersion = "cloud.google.com/v1"
    kind       = "BackendConfig"
    metadata = {
      name      = "${var.GCP_PROJECT_ID}-backend-config-${each.key}"
      namespace = var.GCP_GKE_DEFAULT_NAMESPACE
    }
    spec = {
      timeoutSec = each.value
    }
  }
}

resource "kubernetes_ingress_v1" "primary" {
  metadata {
    name      = "${var.GCP_PROJECT_ID}-ingress-primary"
    namespace = var.GCP_GKE_DEFAULT_NAMESPACE
    annotations = {
      name                                          = "${var.GCP_PROJECT_ID}-ingress-primary"
      "kubernetes.io/ingress.class"                 = "gce"
      "kubernetes.io/ingress.global-static-ip-name" = var.GCP_GKE_IP_NAME
      "cloud.google.com/neg"                        = "{\"ingress\": true}"
      "networking.gke.io/managed-certificates"      = kubernetes_manifest.certificate.manifest.metadata.name
      "networking.gke.io/v1beta1.FrontendConfig"    = kubernetes_manifest.frontend.manifest.metadata.name
      "cloud.google.com/backend-config"             = jsonencode(local.backend_config_annotation_map)
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