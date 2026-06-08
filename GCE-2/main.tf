resource "google_compute_firewall" "allow_rdp" {
  name    = "allow-rdp"
  network = var.network_name
 

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "windows_vm" {
  name         = "windows-iis-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/family/windows-2019"
      size  = 50
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

 service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}