output "primary_vpc_name" {
  value       = google_compute_network.primary.name
  description = "Primary VPC Name"
}

output "primary_subnet_name" {
  value       = google_compute_subnetwork.primary.name
  description = "Primary Subnet Name"
}

output "primary_ip_name" {
  value       = google_compute_address.primary.name
  description = "Primary IP Name"
}

output "primary_ip_address" {
  value       = google_compute_address.primary.address
  description = "Primary IP Address"
}
