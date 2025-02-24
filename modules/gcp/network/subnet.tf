resource "google_compute_subnetwork" "primary" {
  project       = var.GCP_PROJECT_ID
  name          = "${var.GCP_PROJECT_ID}-subnet-primary"
  region        = var.GCP_REGION_ID
  network       = google_compute_network.primary.name
  ip_cidr_range = "10.10.0.0/24"
}