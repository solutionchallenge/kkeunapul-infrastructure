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

module "network" {
  source          = "./modules/gcp/network"
  GCP_PROJECT_ID  = var.GCP_PROJECT_ID
  GCP_REGION_ID   = var.GCP_REGION_ID
  GCP_CERT_DOMAIN = var.CF_DOMAIN_NAME
}

module "kubernetes" {
  source              = "./modules/gcp/kubernetes"
  GCP_PROJECT_ID      = var.GCP_PROJECT_ID
  GCP_REGION_ID       = var.GCP_REGION_ID
  GCP_GKE_VPC_NAME    = module.network.primary_vpc_name
  GCP_GKE_SUBNET_NAME = module.network.primary_subnet_name
  GCP_GKE_IP_NAME     = module.network.primary_ip_name
  GCP_GKE_INGRESS_RULE = [{
    http = {
      path = [{
        path      = "/"
        path_type = "Prefix"
        backend = {
          service = {
            name = "echo"
            port = {
              number = 80
            }
          }
        }
      }]
    }
  }]
  GCP_GKE_INGRESS_CERT = module.network.primary_cert_name
}

module "echo" {
  source            = "./modules/gcp/service"
  SERVICE_NAME      = "echo"
  SERVICE_CLUSTER   = module.kubernetes.primary_cluster_name
  SERVICE_REGION    = var.GCP_REGION_ID
  SERVICE_NAMESPACE = module.kubernetes.primary_cluster_namespace
  SERVICE_IMAGE     = "hashicorp/http-echo"
  SERVICE_PORT      = 5678
  SERVICE_ARGS      = ["-text", "hello-world"]
  SERVICE_REPLICAS  = 1
  SERVICE_CPU       = ["200m", "200m"]
  SERVICE_MEMORY    = ["128Mi", "128Mi"]
}