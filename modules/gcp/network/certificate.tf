resource "google_compute_managed_ssl_certificate" "primary" {
  name = "${var.GCP_PROJECT_ID}-ssl-cert"

  managed {
    domains = [var.GCP_CERT_DOMAIN]
  }
}
