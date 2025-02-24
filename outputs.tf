output "k8s_primary_ingress_ip" {
  value       = module.compute.k8s_primary_ingress_ip
  description = "Kubernetes Ingress IP"
}
