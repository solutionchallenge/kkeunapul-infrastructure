data "external" "digest" {
  program = ["bash", "-c", <<EOT
    gcloud container images describe gcr.io/${var.SERVICE_PROJECT}/${var.SERVICE_NAME}:latest \
      --format='get(image_summary.digest)' --verbosity=none
  EOT
  ]
}

resource "kubernetes_deployment_v1" "service" {
  metadata {
    name      = var.SERVICE_NAME
    namespace = var.SERVICE_NAMESPACE
    labels = {
      app = var.SERVICE_NAME
    }
    annotations = {
      "cloud.google.com/neg"   = "{\"ingress\": true}"
      "DEPLOYMENT_FINGERPRINT" = timestamp()
    }
  }
  spec {
    replicas = var.SERVICE_REPLICAS
    selector {
      match_labels = {
        app = var.SERVICE_NAME
      }
    }
    template {
      metadata {
        labels = {
          app = var.SERVICE_NAME
        }
        annotations = {
          "IMAGE_FINGERPRINT" = data.external.digest.result["digest"]
        }
      }
      spec {
        container {
          name  = var.SERVICE_NAME
          image = var.SERVICE_IMAGE
          args  = var.SERVICE_ARGS
          port {
            container_port = var.SERVICE_PORT
          }
          resources {
            requests = {
              cpu    = var.SERVICE_CPU.0
              memory = var.SERVICE_MEMORY.0
            }
            limits = {
              cpu    = var.SERVICE_CPU.1
              memory = var.SERVICE_MEMORY.1
            }
          }
          liveness_probe {
            http_get {
              path = var.SERVICE_HEALTHCHECK_PATH
              port = var.SERVICE_PORT
            }
            initial_delay_seconds = var.SERVICE_HEALTHCHECK_DELAY
            period_seconds        = var.SERVICE_HEALTHCHECK_PERIOD
          }
          readiness_probe {
            http_get {
              path = var.SERVICE_HEALTHCHECK_PATH
              port = var.SERVICE_PORT
            }
            initial_delay_seconds = var.SERVICE_HEALTHCHECK_DELAY
            period_seconds        = var.SERVICE_HEALTHCHECK_PERIOD
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "service" {
  metadata {
    name      = var.SERVICE_NAME
    namespace = var.SERVICE_NAMESPACE
    annotations = {
      "cloud.google.com/neg" = "{\"ingress\": true}"
    }
  }
  spec {
    type = "NodePort"
    selector = {
      app = var.SERVICE_NAME
    }
    port {
      port        = var.SERVICE_EXPOSE
      target_port = var.SERVICE_PORT
    }
  }
  depends_on = [kubernetes_deployment_v1.service]
}