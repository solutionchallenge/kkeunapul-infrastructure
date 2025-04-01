variable "SERVICE_NAME" {
  type        = string
  description = "Service Name"
}

variable "SERVICE_CLUSTER" {
  type        = string
  description = "Service Cluster"
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

variable "SERVICE_ARGS" {
  type        = list(string)
  nullable    = true
  description = "Service Arguments"
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

variable "SERVICE_CPU" {
  type        = tuple([string, string])
  default     = ["500m", "500m"]
  description = "Service CPU (Request, Limit)"
}

variable "SERVICE_MEMORY" {
  type        = tuple([string, string])
  default     = ["256Mi", "256Mi"]
  description = "Service Memory (Request, Limit)"
}

variable "SERVICE_HEALTHCHECK_PATH" {
  type        = string
  default     = "/health"
  description = "Service Health-check Path"
}

variable "SERVICE_HEALTHCHECK_DELAY" {
  type        = number
  default     = 5
  description = "Service Health-check Delay (sec)"
}

variable "SERVICE_HEALTHCHECK_PERIOD" {
  type        = number
  default     = 30
  description = "Service Health-check Period (sec)"
}
