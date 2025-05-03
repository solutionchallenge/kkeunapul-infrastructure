resource "google_compute_firewall" "database" {
  project     = var.GCP_PROJECT_ID
  name        = "${var.GCP_PROJECT_ID}-fw-database"
  network     = google_compute_network.primary.name
  direction   = "INGRESS"
  priority    = 1000
  target_tags = ["gcp-access-database"]

  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }

  source_ranges = ["10.10.0.0/24"]
} 