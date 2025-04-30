resource "google_service_networking_connection" "primary" {
  network                 = google_compute_network.primary.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.peering.name]
}