resource "google_compute_global_address" "primary" {
  project      = var.GCP_PROJECT_ID
  name         = "${var.GCP_PROJECT_ID}-ip-primary"
  address_type = "EXTERNAL"
}

resource "google_compute_global_address" "peering" {
  project       = var.GCP_PROJECT_ID
  name          = "${var.GCP_PROJECT_ID}-ip-peering"
  address_type  = "INTERNAL"
  prefix_length = 16
  purpose       = "VPC_PEERING"
  network       = google_compute_network.primary.id
}