resource "google_project_service" "enable" {
  for_each = toset([
    "container.googleapis.com",
    "compute.googleapis.com",
    "artifactregistry.googleapis.com",
    "certificatemanager.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ])
  project = var.GCP_PROJECT_ID
  service = each.key
}