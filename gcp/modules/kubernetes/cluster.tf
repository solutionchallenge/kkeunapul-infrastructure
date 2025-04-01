resource "google_container_cluster" "primary" {
  project                  = var.GCP_PROJECT_ID
  name                     = "${var.GCP_PROJECT_ID}-k8s-primary"
  location                 = var.GCP_REGION_ID
  node_locations           = local.node_locations_to_use
  remove_default_node_pool = true
  min_master_version       = "1.30"
  initial_node_count       = var.GCP_GKE_NODE_NUM
  network                  = var.GCP_GKE_VPC_NAME
  subnetwork               = var.GCP_GKE_SUBNET_NAME
}
