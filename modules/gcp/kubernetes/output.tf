output "primary_cluster_id" {
  value       = google_container_cluster.primary.id
  description = "Kubernetes Primary Cluster ID"
}

output "primary_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "Kubernetes Primary Cluster Name"
}

output "primary_cluster_region" {
  value       = var.GCP_REGION_ID
  description = "Kubernetes Primary Cluster Region"
}

output "primary_cluster_namespace" {
  value       = var.GCP_GKE_DEFAULT_NAMESPACE
  description = "Kubernetes Primary Cluster Namespace"
}

output "primary_ingress_ip" {
  value       = var.GCP_GKE_IP_NAME
  description = "Kubernetes Primary IP Name"
}

output "primary_ingress_name" {
  value       = var.GCP_GKE_INGRESS_NAME
  description = "Kubernetes Primary Ingress Name"
}