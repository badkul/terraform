terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "project-a0d9d954-ea3e-4055-bea"
  region  = var.region
  zone    = var.zone
}