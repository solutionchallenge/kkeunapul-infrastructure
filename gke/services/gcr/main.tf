data "external" "digest" {
  program = ["bash", "-c", <<EOT
    DIGEST=$(gcloud container images list-tags gcr.io/${var.SERVICE_PROJECT}/${var.SERVICE_IMAGE} \
      --filter="tags:latest" --format="json" | jq -r 'if length > 0 then .[0].digest else "unknown" end')
    echo "{ \"digest\": \"$DIGEST\" }"
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
          image = "gcr.io/${var.SERVICE_PROJECT}/${var.SERVICE_IMAGE}@${data.external.digest.result["digest"]}"
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
          dynamic "env" {
            for_each = var.SERVICE_ENVS != null ? var.SERVICE_ENVS : []
            content {
              name = env.value.name
              value_from {
                secret_key_ref {
                  name = env.value.secret_name
                  key  = env.value.secret_key
                }
              }
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

resource "kubernetes_manifest" "backend_config" {
  manifest = {
    apiVersion = "cloud.google.com/v1"
    kind       = "BackendConfig"
    metadata = {
      name      = "${var.SERVICE_NAME}-backend-config"
      namespace = var.SERVICE_NAMESPACE
    }
    spec = {
      timeoutSec = var.SERVICE_REQUEST_TIMEOUT
      connectionDraining = {
        drainingTimeoutSec = var.SERVICE_DRAINING_TIMEOUT
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
      "cloud.google.com/backend-config" = jsonencode({
        "default" = "${var.SERVICE_NAME}-backend-config"
      })
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
  depends_on = [kubernetes_deployment_v1.service, kubernetes_manifest.backend_config]
}