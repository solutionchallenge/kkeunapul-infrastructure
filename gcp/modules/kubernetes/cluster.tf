resource "google_container_cluster" "primary" {
  project                  = var.GCP_PROJECT_ID
  name                     = "${var.GCP_PROJECT_ID}-k8s-primary"
  location                 = var.GCP_REGION_ID
  node_locations           = var.GCP_LOCATION_IDS != null && length(var.GCP_LOCATION_IDS) > 0 ? var.GCP_LOCATION_IDS : null
  remove_default_node_pool = true
  min_master_version       = "1.30"
  initial_node_count       = var.GCP_GKE_NODE_NUM
  network                  = var.GCP_GKE_VPC_NAME
  subnetwork               = var.GCP_GKE_SUBNET_NAME
}
