data "google_client_config" "default" {}

data "google_container_cluster" "primary" {
  name     = "${google_container_cluster.primary.name}"
  location = var.GCP_REGION_ID
}

provider "kubernetes" {
  config_context_cluster = "${google_container_cluster.primary.name}"
  host                   = "https://${data.google_container_cluster.primary.endpoint}"
  token                  = "${data.google_client_config.default.access_token}"
  cluster_ca_certificate = "${base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)}"
}
