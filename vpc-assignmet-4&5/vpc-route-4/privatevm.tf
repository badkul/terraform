resource "google_compute_instance" "private_web_vm" {
  name         = "private-web-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = data.google_compute_network.existing_vpc.id
    subnetwork = data.google_compute_subnetwork.private_subnet.id
    # ❌ NO access_config → no external IP
  }

  tags = ["private-web"]
}