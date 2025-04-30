resource "random_password" "database" {
  for_each = { for k, v in var.GCP_DB_USERS : k => v if v.password == "" }

  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  upper            = true
  lower            = true
  numeric          = true

  keepers = {
    user_key = each.key
  }
}

resource "google_sql_user" "global" {
  for_each = var.GCP_DB_USERS
  project  = var.GCP_PROJECT_ID
  instance = google_sql_database_instance.primary.name
  name     = "${var.GCP_PROJECT_ID}-dba-${each.value.name}"
  password = each.value.password != "" ? each.value.password : random_password.database[each.key].result
}