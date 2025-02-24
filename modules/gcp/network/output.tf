output "vpc_primary_name" {
  value       = google_compute_network.primary.name
  description = "Primary VPC Name"
}

output "subnet_primary_name" {
  value       = google_compute_subnetwork.primary.name
  description = "Primary Subnet Name"
}

output "ip_primary_name" {
  value       = google_compute_address.primary.name
  description = "Primary IP Name"
}

output "ip_primary_address" {
  value       = google_compute_address.primary.address
  description = "Primary IP Address"
}
