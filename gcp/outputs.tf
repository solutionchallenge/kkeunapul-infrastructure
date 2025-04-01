output "primary_ingress_ip" {
  value       = module.network.primary_ip_address
  description = "Kubernetes Ingress IP"
}

output "primary_cluster_name" {
  value       = module.kubernetes.primary_cluster_name
  description = "Kubernetes Primary Cluster Name"
}

output "primary_cluster_region" {
  value       = module.kubernetes.primary_cluster_region
  description = "Kubernetes Primary Cluster Region"
}
