output "primary_db_instance_id" {
  value       = google_sql_database_instance.primary.id
  description = "Cloud SQL Primary Instance ID"
}

output "primary_db_instance_name" {
  value       = google_sql_database_instance.primary.name
  description = "Cloud SQL Primary Instance Name"
}

output "primary_db_connection_name" {
  value       = google_sql_database_instance.primary.connection_name
  description = "Cloud SQL Primary Instance Connection Name"
}

output "primary_db_private_ip" {
  value       = google_sql_database_instance.primary.private_ip_address
  description = "Cloud SQL Primary Instance Private IP"
}

output "primary_db_public_ip" {
  value       = google_sql_database_instance.primary.public_ip_address
  description = "Cloud SQL Primary Instance Public IP"
} 