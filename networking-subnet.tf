resource "google_compute_subnetwork" "subnet_main" {
  project       = var.GCP_PROJECT_ID
  name          = "${var.GCP_PROJECT_ID}-subnet-main"
  region        = var.GCP_REGION_ID
  network       = google_compute_network.vpc_main.name
  ip_cidr_range = "10.10.0.0/24"
}