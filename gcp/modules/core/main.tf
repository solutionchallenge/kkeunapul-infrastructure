resource "google_project_service" "enable" {
  for_each = toset([
    "container.googleapis.com",            # Kubernetes Engine API
    "compute.googleapis.com",              # Compute Engine API
    "artifactregistry.googleapis.com",     # Artifact Registry API
    "certificatemanager.googleapis.com",   # Certificate Manager API
    "cloudresourcemanager.googleapis.com", # Cloud Resource Manager API
    "monitoring.googleapis.com",           # Cloud Monitoring API
    "logging.googleapis.com",              # Cloud Logging API
    "serviceusage.googleapis.com"          # Service Usage API
  ])
  project = var.GCP_PROJECT_ID
  service = each.key
}