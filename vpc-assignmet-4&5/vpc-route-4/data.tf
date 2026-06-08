# Fetch existing VPC
data "google_compute_network" "existing_vpc" {
  name = var.vpc_name
}

# Fetch existing VM that will act as router
data "google_compute_instance" "router_vm" {
  name = var.router_vm_name
  zone = var.router_vm_zone
}

data "google_compute_subnetwork" "private_subnet" {
  name   = "private-subnet"
  region = "us-central1"
}