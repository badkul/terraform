resource "google_compute_backend_service" "backend" {
  name          = "web-backend"
  protocol      = "HTTP"
  port_name     = "http"
  health_checks = [google_compute_health_check.http_check.id]

  backend {
    group = google_compute_instance_group_manager.web_mig.instance_group
  }
}

resource "google_compute_instance_group_manager" "web_mig" {
  name               = "web-mig"
  zone               = var.zone
  base_instance_name = "web"
  target_size        = 2

  version {
    instance_template = google_compute_instance_template.web_template.id
  }

  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_autoscaler" "web_autoscaler" {
  name   = "web-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.web_mig.id

  autoscaling_policy {
    min_replicas    = 2
    max_replicas    = 4
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
  }
}

resource "google_compute_health_check" "http_check" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}

resource "google_compute_instance_template" "web_template" {
  name_prefix  = "web-template-"
  machine_type = "e2-micro"
  tags         = ["web-server"]

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = var.subnetwork
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    echo "<h1>Served from $(hostname)</h1>" > /var/www/html/index.html
    systemctl restart nginx
  EOF
}
resource "google_compute_url_map" "url_map" {
  name            = "web-url-map"
  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "web-http-proxy"
  url_map = google_compute_url_map.url_map.id
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name       = "web-forwarding-rule"
  port_range = "80"
  target     = google_compute_target_http_proxy.http_proxy.id
}