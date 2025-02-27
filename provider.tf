data "google_client_config" "default" {}

data "google_container_cluster" "primary" {
  name     = module.kubernetes.primary_cluster_name
  location = var.GCP_REGION_ID
}

provider "google" {
  project = var.GCP_PROJECT_ID
  region  = var.GCP_REGION_ID
}

provider "kubernetes" {
  host                   = "https://${data.google_container_cluster.primary.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}