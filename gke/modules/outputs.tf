output "primary_ingress_ip" {
  value       = var.GCP_GKE_IP_NAME
  description = "Kubernetes Primary IP Name"
}

output "primary_ingress_name" {
  value       = kubernetes_ingress_v1.primary.metadata.0.name
  description = "Kubernetes Primary Ingress Name"
}