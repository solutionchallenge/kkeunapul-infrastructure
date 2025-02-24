output "k8s_primary_cluster_id" {
  value       = google_container_cluster.primary.id
  description = "Kubernetes Primary Cluster ID"
}

output "k8s_primary_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "Kubernetes Primary Cluster Name"
}

output "k8s_primary_cluster_ip" {
  value       = google_container_cluster.primary.services_ipv4_cidr
  description = "Kubernetes Primary Cluster Name"
}