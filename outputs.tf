output "k8s_primary_ingress_ip" {
  value       = module.compute.k8s_primary_cluster_ip
  description = "Kubernetes Cluster Name"
}
