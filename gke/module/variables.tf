variable "GCP_PROJECT_ID" {
  type        = string
  description = "GCP Project ID"
}

variable "GCP_REGION_ID" {
  type        = string
  description = "GCP Region ID"
}

variable "GCP_GKE_IP_NAME" {
  type        = string
  description = "Kubernetes IP Name"
}

variable "GCP_GKE_SSL_DOMAIN" {
  type        = string
  description = "Kubernetes SSL Domain"
}

variable "GCP_GKE_INGRESS_RULE" {
  type = list(object({
    host = optional(string)
    http = object({
      path = list(object({
        path      = string
        path_type = string
        backend = object({
          service = object({
            name = string
            port = object({
              number = number
            })
            timeout = optional(number, 300)
            draining = optional(object({
              timeout = optional(number, 60)
            }), { timeout = 60 })
          })
        })
      }))
    })
  }))
  description = "Kubernetes Ingress Rule"
}

variable "GCP_GKE_DEFAULT_NAMESPACE" {
  type        = string
  default     = "kkeunapul"
  description = "Kubernetes Default Namespace"
}
