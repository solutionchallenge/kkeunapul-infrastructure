resource "google_compute_ssl_policy" "primary" {
  name            = "${var.GCP_PROJECT_ID}-policy"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}

resource "google_compute_managed_ssl_certificate" "primary" {
  name = "${var.GCP_PROJECT_ID}-ssl-cert"

  managed {
    domains = [var.GCP_CERT_DOMAIN]
  }
}
