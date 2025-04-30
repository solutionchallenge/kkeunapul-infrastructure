resource "google_sql_database_instance" "primary" {
  project          = var.GCP_PROJECT_ID
  name             = "${var.GCP_PROJECT_ID}-dbi-primary"
  database_version = var.GCP_DB_FAMILY_VERSION
  region           = var.GCP_REGION_ID

  settings {
    tier = var.GCP_DB_MACHINE_TYPE
    ip_configuration {
      ipv4_enabled                                  = var.GCP_DB_IP_ENABLED
      private_network                               = var.GCP_DB_VPC_LINK
      enable_private_path_for_google_cloud_services = true
    }
  }

  deletion_protection = var.GCP_DB_DELETION_PROTECTION

  depends_on = [var.GCP_DB_SVC_NET]
}
