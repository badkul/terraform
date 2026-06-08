resource "google_compute_instance" "new_vm" {
  name         = var.new_vm_name
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    source = google_compute_disk.disk_from_snapshot.name
    auto_delete = true
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    startup-script = "echo VM created from snapshot > /verification.txt"
  }

  tags = ["snapshot-demo"]
}