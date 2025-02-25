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
  source         = "./modules/infrastructures/gcp/network"
  GCP_PROJECT_ID = var.GCP_PROJECT_ID
  GCP_REGION_ID  = var.GCP_REGION_ID
}

module "kubernetes" {
  source              = "./modules/infrastructures/gcp/kubernetes"
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
}

module "echo" {
  source            = "./modules/services/docker"
  SERVICE_NAME      = "echo"
  SERVICE_NAMESPACE = module.kubernetes.primary_cluster_namespace
  SERVICE_IMAGE     = "hashicorp/http-echo"
  SERVICE_PORT      = 80
}