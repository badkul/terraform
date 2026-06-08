variable "project_id" {
  description = "project-a0d9d954-ea3e-4055-bea"
  type        = string
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "subnetwork" {
  description = "The subnetwork to attach to the instance template"
  type        = string
}