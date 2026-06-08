resource "google_compute_network" "spoke2" {
  name                    = "spoke2-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "spoke2_subnet" {
  name          = "spoke2-subnet"
  network       = google_compute_network.spoke2.id
  region        = var.region
  ip_cidr_range = "10.30.0.0/16"
}

resource "google_compute_instance" "spoke2_vm" {
  name         = "spoke2-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.spoke2_subnet.id
  }

  tags = ["spoke"]
}
