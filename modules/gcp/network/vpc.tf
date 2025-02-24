resource "google_compute_network" "vpc_primary" {
  project                 = var.GCP_PROJECT_ID
  name                    = "${var.GCP_PROJECT_ID}-vpc-primary"
  auto_create_subnetworks = "false"
}