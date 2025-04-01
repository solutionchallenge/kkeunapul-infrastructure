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
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

module "ondaum-client" {
  source                   = "./services/gcr"
  SERVICE_NAME             = "ondaum-client"
  SERVICE_PROJECT          = var.GCP_PROJECT_ID
  SERVICE_CLUSTER          = var.GKE_CLUSTER_NAME
  SERVICE_REGION           = var.GCP_REGION_ID
  SERVICE_NAMESPACE        = "default"  # 적절한 네임스페이스 설정
  SERVICE_IMAGE            = "ondaum-client-amd64"
  SERVICE_ARGS             = null
  SERVICE_PORT             = 80
  SERVICE_EXPOSE           = 80
  SERVICE_REPLICAS         = 1
  SERVICE_CPU              = ["180m", "180m"]
  SERVICE_MEMORY           = ["256Mi", "256Mi"]
  SERVICE_HEALTHCHECK_PATH = "/"
}
