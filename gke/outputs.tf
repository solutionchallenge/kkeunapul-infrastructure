output "primary_ingress_ip" {
  value       = module.gcp.primary_ingress_ip
  description = "Kubernetes Ingress IP"
}

output "primary_ingress_name" {
  value       = module.gcp.primary_ingress_name
  description = "Kubernetes Ingress Name"
}
