variable "SERVICE_NAME" {
  type        = string
  description = "Service Name"
}

variable "SERVICE_REGION" {
  type        = string
  description = "Service Region"
}

variable "SERVICE_NAMESPACE" {
  type        = string
  description = "Service Namespace"
}

variable "SERVICE_IMAGE" {
  type        = string
  description = "Service Image"
}

variable "SERVICE_PORT" {
  type        = number
  description = "Service Port"
}

variable "SERVICE_EXPOSE" {
  type        = number
  default     = 80
  description = "Service Expose"
}

variable "SERVICE_REPLICAS" {
  type        = number
  default     = 1
  description = "Service Replicas"
}