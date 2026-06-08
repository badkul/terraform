resource "google_compute_instance_template" "web_template" {
  name_prefix  = "web-template-"
  machine_type = "e2-micro"

  disk {
    source_image = "projects/debian-cloud/global/images/family/debian-12"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt update
    apt install -y apache2
    echo "Hello from $(hostname)" > /var/www/html/index.html
    systemctl start apache2
  EOF

  tags = ["http-server"]
}

resource "google_compute_backend_service" "web_backend" {
  name                  = "web-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_health_check.http_health_check.id]
  timeout_sec           = 10

  backend {
    group = google_compute_instance_group_manager.web_mig.instance_group
  }
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name       = "http-forwarding-rule"
  port_range = "80"
  target     = google_compute_target_http_proxy.http_proxy.id
}

resource "google_compute_health_check" "http_health_check" {
  name = "http-health-check"

  http_health_check {
    port = 80
    request_path = "/"
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

resource "google_compute_url_map" "web_url_map" {
  name            = "web-url-map"
  default_service = google_compute_backend_service.web_backend.id
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.web_url_map.id
}