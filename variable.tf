variable "project_id" {
  description = "GCP project ID where resources will be created"
  type        = string
  default = "project-a0d9d954-ea3e-4055-bea"
}

variable "region" {
  description = "Default GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Default GCP zone"
  type        = string
  default     = "us-central1-b"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    cidr                    = string
    region                  = string
    private_ip_google_access = optional(bool)
  }))
  default = {
    "subnet-01" = {
      cidr   = "10.128.0.0/20"
      region = "us-central1"
    }
  }
}