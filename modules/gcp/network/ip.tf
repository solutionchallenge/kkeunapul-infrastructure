resource "google_compute_address" "ip_main" {
  project      = var.GCP_PROJECT_ID
  name         = "${var.GCP_PROJECT_ID}-ip-main"
  region       = var.GCP_REGION_ID
  network_tier = "STANDARD"
  address_type = "EXTERNAL"
}