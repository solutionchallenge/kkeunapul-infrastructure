output "primary_ingress_ip" {
  value       = module.network.primary_ip_address
  description = "Kubernetes Ingress IP"
}
