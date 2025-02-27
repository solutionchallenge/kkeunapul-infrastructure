variable "GCP_PROJECT_ID" {
  type        = string
  description = "GCP Project ID"
}

variable "GCP_REGION_ID" {
  type        = string
  description = "GCP Region ID"
}

variable "GCP_GKE_VPC_NAME" {
  type        = string
  description = "Kubernetes VPC Name"
}

variable "GCP_GKE_SUBNET_NAME" {
  type        = string
  description = "Kubernetes Subnet Name"
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
          })
        })
      }))
    })
  }))
  description = "Kubernetes Ingress Rule"
}

variable "GCP_GKE_INGRESS_NAME" {
  type        = string
  default     = "ingress-primary"
  description = "Kubernetes Ingress Name"
}

variable "GCP_GKE_NODE_NUM" {
  type        = number
  default     = 1
  description = "Kubernetes Node Number Per Zone"
}

variable "GCP_GKE_NODE_TYPE" {
  type        = string
  default     = "e2-small"
  description = "Kubernetes Node Machine Type"
}

variable "GCP_GKE_DEFAULT_NAMESPACE" {
  type        = string
  default     = "kkeunapul"
  description = "Kubernetes Default Namespace"
}
