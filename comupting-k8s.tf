resource "google_container_cluster" "primary" {
  project                  = var.GCP_PROJECT_ID
  name                     = "${var.GCP_PROJECT_ID}-k8s-primary"
  location                 = var.GCP_REGION_ID
  min_master_version       = "1.30"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc_main.name
  subnetwork               = google_compute_subnetwork.subnet_main.name
}