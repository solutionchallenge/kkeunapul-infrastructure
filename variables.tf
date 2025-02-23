variable "GCP_PROJECT_ID" {
  type = string
}

variable "GCP_REGION_ID" {
  type = string
}

variable "GCP_GKE_NODE_NUM" {
  type    = number
  default = 1
}

variable "GCP_GKE_NODE_TYPE" {
  type    = string
  default = "e2-micro"
}