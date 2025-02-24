resource "google_compute_address" "primary_ip" {
  project      = var.GCP_PROJECT_ID
  name         = "${var.GCP_PROJECT_ID}-ip-primary"
  region       = var.GCP_REGION_ID
  network_tier = "STANDARD"
  address_type = "EXTERNAL"
}