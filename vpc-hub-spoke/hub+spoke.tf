resource "google_compute_network" "hub_vpc" {
  name                    = "hub-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "hub_subnet" {
  name          = "hub-subnet"
  network       = google_compute_network.hub_vpc.id
  region        = var.region
  ip_cidr_range = "10.10.0.0/16"
}

resource "google_compute_router" "hub_router" {
  name    = "hub-cloud-router"
  network = google_compute_network.hub_vpc.id
  region  = var.region

  bgp {
    asn = 64514
  }
}

resource "google_compute_network" "spoke1" {
  name                    = "spoke-1-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "spoke1_subnet" {
  name          = "spoke-1-subnet"
  network       = google_compute_network.spoke1.id
  region        = var.region
  ip_cidr_range = "10.20.0.0/16"
}

resource "google_compute_instance" "hub_vm" {
  name         = "hub-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.hub_subnet.id
  }

  tags = ["hub"]
}

resource "google_compute_instance" "spoke1_vm" {
  name         = "spoke1-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.spoke1_subnet.id
  }

  tags = ["spoke"]
}


