resource "random_password" "db_user_passwords" {
  for_each = var.GCP_DB_USERS

  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true

  keepers = {
    user_name = each.value.name
  }
}

resource "google_sql_user" "global" {
  for_each = var.GCP_DB_USERS

  project  = var.GCP_PROJECT_ID
  name     = "${var.GCP_PROJECT_ID}-dba-${each.value.name}"
  instance = google_sql_database_instance.primary.name
  password = each.value.password != "" ? each.value.password : random_password.db_user_passwords[each.key].result
} 