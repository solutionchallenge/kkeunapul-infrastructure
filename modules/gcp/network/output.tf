output "vpc_primary_name" {
  value       = google_compute_network.vpc_primary.name
  description = "Primary VPC Name"
}

output "subnet_primary_name" {
  value       = google_compute_subnetwork.subnet_primary.name
  description = "Primary Subnet Name"
}

output "ip_primary_name" {
  value       = google_compute_address.ip_primary.name
  description = "Primary IP Name"
}

output "ip_primary_address" {
  value       = google_compute_address.ip_primary.address
  description = "Primary IP Address"
}
