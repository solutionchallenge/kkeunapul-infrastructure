output "primary_ingress_ip" {
  value       = var.GCP_PRIMARY_IP_ADDRESS
  description = "Kubernetes Ingress IP"
}

output "primary_ingress_name" {
  value       = module.gcp.primary_ingress_name
  description = "Kubernetes Ingress Name"
}
