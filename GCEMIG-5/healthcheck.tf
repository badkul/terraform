resource "google_compute_health_check" "http_health_check" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}