resource "google_sql_database" "primary" {
  project  = var.GCP_PROJECT_ID
  name     = "${var.GCP_PROJECT_ID}-db-primary"
  instance = google_sql_database_instance.primary.name
}
