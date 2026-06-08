terraform {
  required_version = ">= 1.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = "project-a0d9d954-ea3e-4055-bea"
  region  = "us-central1"
}
module "GCE-1" {
  source = "./GCE-1"

  zone       = var.zone
  vm_name    = "nginx-vm-1"
  disk_name  = "nginx-data-disk"

  labels = {
    env = "dev"
    app = "nginx"
  }
}

module "GCE-2" {
source = "./GCE-2"
}

module "GCE-3" {
source = "./GCE-3"
}

module "GCEsnapshot-4" {
  source = "./GCEsnapshot-4"
  project_id = var.project_id
  source_vm_name = "nginx-vm-1"
}

module "GCEMIG-5" {
  source     = "./GCEMIG-5"
  project_id = var.project_id
}

module "gcp-http-lb-terraform-6" {
  source = "./gcp-http-lb-terraform-6"
  project_id = var.project_id
}

module "gcp-lb-mig-7" {
  source = "./gcp-lb-mig-7"
  project_id = var.project_id
  subnetwork = google_compute_subnetwork.subnet.id
}


module "vpc" {
  source   = "./modules/vpc"
  vpc_name = var.vpc_name
  subnets  = var.subnets
}
