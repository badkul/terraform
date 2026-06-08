resource "google_compute_snapshot" "boot_snapshot" {
  name        = var.snapshot_name
  source_disk = data.google_compute_instance.source_vm.boot_disk[0].source
  zone        = "us-central1-a"

  labels = {
    env = "backup"
  }
}

