variable "GCP_PROJECT_ID" {
  type = string
}

variable "GCP_REGION_ID" {
  type = string
}

variable "CF_DOMAIN_NAME" {
  type = string
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  description = "GKE cluster name created by infra workspace"
}
