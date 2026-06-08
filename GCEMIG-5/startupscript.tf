resource "google_compute_instance_template" "app_template" {
  name_prefix  = "app-template-"
  machine_type = var.machine_type

  disk {
    boot         = true
    auto_delete = true
    source_image = "debian-cloud/debian-12"
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = file("${path.module}/startup.sh")

  tags = ["http-server"]

  lifecycle {
    create_before_destroy = true
  }
}