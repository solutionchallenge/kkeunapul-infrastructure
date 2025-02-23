output "k8s_cluster_id" {
  value       = google_container_cluster.primary.id
  description = "Kubernetes Cluster ID"
}

output "k8s_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "Kubernetes Cluster Name"
}