output "k8s_primary_cluster_id" {
  value       = google_container_cluster.primary.id
  description = "Kubernetes Primary Cluster ID"
}

output "k8s_primary_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "Kubernetes Primary Cluster Name"
}

output "k8s_primary_cluster_namespace" {
  value       = var.GCP_GKE_DEFAULT_NAMESPACE
  description = "Kubernetes Primary Cluster Namespace"
}

output "k8s_primary_ingress_ip" {
  value       = var.GCP_GKE_INGRESS_IP
  description = "Kubernetes Primary Ingress IP (Name)"
}