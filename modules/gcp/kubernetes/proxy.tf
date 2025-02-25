resource "kubernetes_deployment_v1" "proxy" {
  metadata {
    name      = "default-proxy"
    namespace = var.GCP_GKE_DEFAULT_NAMESPACE
    labels = {
      app = "default-proxy"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "default-proxy"
      }
    }
    template {
      metadata {
        labels = {
          app = "default-proxy"
        }
      }
      spec {
        container {
          name  = "default-proxy"
          image = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
  depends_on = [kubernetes_namespace.default]
}

resource "kubernetes_service_v1" "proxy" {
  metadata {
    name      = "default-proxy"
    namespace = var.GCP_GKE_DEFAULT_NAMESPACE
  }
  spec {
    type = "LoadBalancer"
    selector = {
      app = "default-proxy"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
  depends_on = [kubernetes_deployment_v1.proxy]
}