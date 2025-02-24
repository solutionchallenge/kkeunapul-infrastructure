output "vpc_main_name" {
  value       = google_compute_network.vpc_main.name
  description = "Main VPC Name"
}

output "subnet_main_name" {
  value       = google_compute_subnetwork.subnet_main.name
  description = "Main Subnet Name"
}

output "ip_main_name" {
  value       = google_compute_address.ip_main.name
  description = "Main IP Name"
}

output "ip_main_address" {
  value       = google_compute_address.ip_main.address
  description = "Main IP Address"
}
