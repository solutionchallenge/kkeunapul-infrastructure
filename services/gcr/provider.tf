data "google_client_config" "default" {}

data "google_container_cluster" "primary" {
  name     = var.SERVICE_CLUSTER
  location = var.SERVICE_REGION
}

provider "google" {
  project = var.SERVICE_PROJECT
  region  = var.SERVICE_REGION
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}
