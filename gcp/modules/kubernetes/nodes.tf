resource "google_container_node_pool" "primary" {
  project        = var.GCP_PROJECT_ID
  name           = "${var.GCP_PROJECT_ID}-nodes-primary"
  location       = var.GCP_REGION_ID
  node_locations = var.GCP_LOCATION_IDS != null && length(var.GCP_LOCATION_IDS) > 0 ? var.GCP_LOCATION_IDS : null
  cluster        = google_container_cluster.primary.name
  node_count     = var.GCP_GKE_NODE_NUM
  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    labels = {
      env = var.GCP_PROJECT_ID
    }
    machine_type = var.GCP_GKE_NODE_TYPE
    tags         = ["k8s-nodes", "${var.GCP_PROJECT_ID}-k8s-primary"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}