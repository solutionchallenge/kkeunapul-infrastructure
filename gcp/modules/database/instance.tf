resource "google_sql_database_instance" "primary" {
  project          = var.GCP_PROJECT_ID
  name             = "${var.GCP_PROJECT_ID}-dbi-primary"
  database_version = var.GCP_DB_FAMILY_VERSION
  region           = var.GCP_REGION_ID

  settings {
    tier = var.GCP_DB_MACHINE_TYPE
    ip_configuration {
      ipv4_enabled    = var.GCP_DB_PUBLIC_IP
      private_network = var.GCP_DB_VPC_NAME
    }
  }

  deletion_protection = var.GCP_DB_DELETION_PROTECTION
}
