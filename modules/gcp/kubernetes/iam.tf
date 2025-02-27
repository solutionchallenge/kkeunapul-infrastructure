resource "google_project_iam_member" "artifact" {
  project = var.GCP_PROJECT_ID
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_container_node_pool.primary.node_config.0.service_account}"
}