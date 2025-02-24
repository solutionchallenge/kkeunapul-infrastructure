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
  source         = "./modules/gcp/network"
  GCP_PROJECT_ID = var.GCP_PROJECT_ID
  GCP_REGION_ID  = var.GCP_REGION_ID
}

module "compute" {
  source              = "./modules/gcp/compute"
  GCP_PROJECT_ID      = var.GCP_PROJECT_ID
  GCP_REGION_ID       = var.GCP_REGION_ID
  GCP_GKE_VPC_NAME    = module.network.vpc_main_name
  GCP_GKE_SUBNET_NAME = module.network.subnet_main_name
  GCP_GKE_INGRESS_IP  = module.network.ip_main_name
}
