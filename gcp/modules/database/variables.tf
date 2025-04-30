variable "GCP_PROJECT_ID" {
  type        = string
  description = "GCP Project ID"
}

variable "GCP_REGION_ID" {
  type        = string
  description = "GCP Region ID"
}

variable "GCP_DB_FAMILY_VERSION" {
  type        = string
  default     = "MYSQL_8_0"
  description = "Cloud SQL Database Version"
}

variable "GCP_DB_MACHINE_TYPE" {
  type        = string
  default     = "db-g1-small"
  description = "Cloud SQL Machine Type"
}

variable "GCP_DB_PUBLIC_IP" {
  type        = bool
  default     = false
  description = "Enable Public IP for Cloud SQL"
}

variable "GCP_DB_PRIVATE_NETWORK" {
  type        = string
  description = "Cloud SQL Private Network ID"
}

variable "GCP_DB_DELETION_PROTECTION" {
  type        = bool
  default     = true
  description = "Enable Cloud SQL Deletion Protection"
}

variable "GCP_DB_USERS" {
  type = map(object({
    name     = string
    password = string
  }))
  sensitive   = true
  description = "Cloud SQL Database Users"
} 