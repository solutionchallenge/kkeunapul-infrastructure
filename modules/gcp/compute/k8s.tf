resource "google_container_cluster" "primary" {
  project                  = var.GCP_PROJECT_ID
  name                     = "${var.GCP_PROJECT_ID}-k8s-primary"
  location                 = var.GCP_REGION_ID
  min_master_version       = "1.30"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.GCP_GKE_VPC_NAME
  subnetwork               = var.GCP_GKE_SUBNET_NAME
  depends_on               = [google_container_node_pool.primary]
}