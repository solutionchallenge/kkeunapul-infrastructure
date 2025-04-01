output "primary_ingress_ip" {
  value       = kubernetes_ingress_v1.primary.status.0.load_balancer.0.ingress.0.ip
  description = "Kubernetes Primary Ingress IP Address"
}

output "primary_ingress_name" {
  value       = kubernetes_ingress_v1.primary.metadata.0.name
  description = "Kubernetes Primary Ingress Name"
}

output "primary_cluster_namespace" {
  value       = var.GCP_GKE_DEFAULT_NAMESPACE
  description = "Kubernetes Primary Cluster Namespace"
}
