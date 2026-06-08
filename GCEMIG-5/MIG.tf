resource "google_compute_instance_group_manager" "app_mig" {
  name               = "app-mig"
  base_instance_name = "app"
  zone               = var.zone

  version {
    instance_template = google_compute_instance_template.app_template.id
  }

  target_size = 2

  auto_healing_policies {
    health_check      = google_compute_health_check.http_health_check.id
    initial_delay_sec = 60
  }
}