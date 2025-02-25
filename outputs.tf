output "primary_ingress_ip" {
  value       = module.network.primary_ip_address
  description = "Kubernetes Ingress IP"
}

output "primary_ip_identifier" {
  value       = module.network.primary_ip_name
  description = "Kubernetes IP Identifier"
}
