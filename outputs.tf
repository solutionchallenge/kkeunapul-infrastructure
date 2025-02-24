output "kubernetes_primary_ingress_ip" {
  value       = module.kubernetes.primary_ingress_ip
  description = "Kubernetes Ingress IP"
}
