output "vpc_main_name" {
  value       = google_compute_network.vpc_main.name
  description = "Main VPC Name"
}

output "subnet_main_name" {
  value       = google_compute_subnetwork.subnet_main.name
  description = "Main Subnet Name"
}
