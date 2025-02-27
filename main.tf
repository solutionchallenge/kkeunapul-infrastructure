# Manage 'tfstate' on the alternative provider. (for HA)
terraform {
  backend "s3" {
    region                      = "auto"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

locals {
  ingress = yamldecode(file("${path.root}/configs/kubernetes/ingress.yaml"))
}

module "core" {
  source         = "./modules/gcp/core"
  GCP_PROJECT_ID = var.GCP_PROJECT_ID
}

module "network" {
  source          = "./modules/gcp/network"
  GCP_PROJECT_ID  = var.GCP_PROJECT_ID
  GCP_REGION_ID   = var.GCP_REGION_ID
  GCP_CERT_DOMAIN = var.CF_DOMAIN_NAME
}

module "kubernetes" {
  source               = "./modules/gcp/kubernetes"
  GCP_PROJECT_ID       = var.GCP_PROJECT_ID
  GCP_REGION_ID        = var.GCP_REGION_ID
  GCP_GKE_VPC_NAME     = module.network.primary_vpc_name
  GCP_GKE_SUBNET_NAME  = module.network.primary_subnet_name
  GCP_GKE_IP_NAME      = module.network.primary_ip_name
  GCP_GKE_SSL_CERT     = module.network.primary_ssl_cert
  GCP_GKE_SSL_POLICY   = module.network.primary_ssl_policy
  GCP_GKE_INGRESS_RULE = local.ingress["rules"]
}

module "echo" {
  source            = "./services/gcp/gcr"
  SERVICE_NAME      = "echo"
  SERVICE_PROJECT   = var.GCP_PROJECT_ID
  SERVICE_CLUSTER   = module.kubernetes.primary_cluster_name
  SERVICE_REGION    = module.kubernetes.primary_cluster_region
  SERVICE_NAMESPACE = module.kubernetes.primary_cluster_namespace
  SERVICE_IMAGE     = "http-echo-amd64"
  SERVICE_PORT      = 5678
  SERVICE_EXPOSE    = 443
  SERVICE_ARGS      = ["-text", "hello-world"]
  SERVICE_REPLICAS  = 1
  SERVICE_CPU       = ["200m", "200m"]
  SERVICE_MEMORY    = ["128Mi", "128Mi"]
}