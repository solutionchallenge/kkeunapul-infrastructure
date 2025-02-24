output "k8s_cluster_id" {
  value       = google_container_cluster.primary.id
  description = "Kubernetes Cluster ID"
}

output "k8s_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "Kubernetes Cluster Name"
}

output "k8s_cluster_ip" {
  value       = google_container_cluster.primary.services_ipv4_cidr
  description = "Kubernetes Cluster Name"
}
