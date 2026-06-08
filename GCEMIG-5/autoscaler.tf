resource "google_compute_autoscaler" "cpu_autoscaler" {
  name   = "app-mig-cpu-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.app_mig.id

  autoscaling_policy {
    min_replicas = 2
    max_replicas = 5
    cooldown_period = 60

    cpu_utilization {
      target = 0.6   # scale when average CPU > 60%
    }
  }
}