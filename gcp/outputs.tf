output "primary_ip_address" {
  value       = module.network.primary_ip_address
  description = "Service Primary IP Address"
}

output "primary_ip_name" {
  value       = module.network.primary_ip_name
  description = "Service Primary IP Name"
}

output "primary_cluster_name" {
  value       = module.kubernetes.primary_cluster_name
  description = "Kubernetes Primary Cluster Name"
}

output "primary_cluster_region" {
  value       = module.kubernetes.primary_cluster_region
  description = "Kubernetes Primary Cluster Region"
}
