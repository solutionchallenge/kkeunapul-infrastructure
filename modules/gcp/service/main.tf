resource "kubernetes_deployment_v1" "service" {
  metadata {
    name      = var.SERVICE_NAME
    namespace = var.SERVICE_NAMESPACE
    labels = {
      app = var.SERVICE_NAME
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
      }
      spec {
        container {
          name  = var.SERVICE_NAME
          image = var.SERVICE_IMAGE
          args  = var.SERVICE_ARGS
          port {
            container_port = var.SERVICE_PORT
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
  }
  spec {
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