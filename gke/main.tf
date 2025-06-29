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


locals {
  ingress            = yamldecode(file("${path.root}/configs/ingress.yaml"))
  ondaum_server_envs = yamldecode(file("${path.root}/environments/ondaum-server.yaml"))
}

module "gcp" {
  source               = "./module"
  GCP_PROJECT_ID       = var.GCP_PROJECT_ID
  GCP_REGION_ID        = var.GCP_REGION_ID
  GCP_GKE_IP_NAME      = var.GCP_PRIMARY_IP_NAME
  GCP_GKE_SSL_DOMAIN   = var.CF_DOMAIN_NAME
  GCP_GKE_INGRESS_RULE = local.ingress["rules"]
}

module "ondaum-client" {
  source                   = "./services/gcr"
  SERVICE_NAME             = "ondaum-client"
  SERVICE_PROJECT          = var.GCP_PROJECT_ID
  SERVICE_CLUSTER          = var.GCP_GKE_CLUSTER_NAME
  SERVICE_REGION           = var.GCP_REGION_ID
  SERVICE_NAMESPACE        = module.gcp.primary_cluster_namespace
  SERVICE_IMAGE            = "ondaum-client-amd64"
  SERVICE_ENVS             = null
  SERVICE_ARGS             = null
  SERVICE_PORT             = 80
  SERVICE_EXPOSE           = 80
  SERVICE_REPLICAS         = 1
  SERVICE_CPU              = ["180m", "180m"]
  SERVICE_MEMORY           = ["256Mi", "256Mi"]
  SERVICE_HEALTHCHECK_PATH = "/"
}

module "ondaum-server" {
  source                   = "./services/gcr"
  SERVICE_NAME             = "ondaum-server"
  SERVICE_PROJECT          = var.GCP_PROJECT_ID
  SERVICE_CLUSTER          = var.GCP_GKE_CLUSTER_NAME
  SERVICE_REGION           = var.GCP_REGION_ID
  SERVICE_NAMESPACE        = module.gcp.primary_cluster_namespace
  SERVICE_IMAGE            = "ondaum-server-amd64"
  SERVICE_ENVS             = local.ondaum_server_envs
  SERVICE_ARGS             = null
  SERVICE_PORT             = 8080
  SERVICE_EXPOSE           = 8080
  SERVICE_REPLICAS         = 1
  SERVICE_CPU              = ["180m", "180m"]
  SERVICE_MEMORY           = ["256Mi", "256Mi"]
  SERVICE_HEALTHCHECK_PATH = "/api/v1/_sys/health"
  SERVICE_REQUEST_TIMEOUT  = 86400
  SERVICE_DRAINING_TIMEOUT = 60
}
