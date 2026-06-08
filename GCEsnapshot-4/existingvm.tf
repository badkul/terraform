data "google_compute_instance" "source_vm" {
  name = "vm1"
  zone = "us-central1-a"
}