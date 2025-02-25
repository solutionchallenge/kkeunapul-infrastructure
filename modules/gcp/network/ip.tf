resource "google_compute_global_address" "primary" {
  project      = var.GCP_PROJECT_ID
  name         = "${var.GCP_PROJECT_ID}-ip-primary"
  address_type = "EXTERNAL"
}