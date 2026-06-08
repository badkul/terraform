variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "router_vm_name" {
  description = "Name of the existing VM acting as router"
  type        = string
}

variable "router_vm_zone" {
  description = "Zone where the router VM exists"
  type        = string
}

variable "vpc_name" {
  description = "Name of the existing VPC"
  type        = string
}

variable "subnet_self_link" {
  description = "Self link of the subnet to enable Cloud NAT"
  type        = string
}

variable "subnet_name" {
  description = "Name of the existing subnet for private VM"
  type        = string
}