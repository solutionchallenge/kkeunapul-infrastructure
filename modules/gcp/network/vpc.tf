resource "google_compute_network" "vpc_main" {
  project                 = var.GCP_PROJECT_ID
  name                    = "${var.GCP_PROJECT_ID}-vpc-main"
  auto_create_subnetworks = "false"
}