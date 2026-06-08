terraform {
required_providers {
google = {
source  = "hashicorp/google"
version = "~> 7.0"
}
}
}

provider "google" {
project = "project-a0d9d954-ea3e-4055-bea"
region  = "us-central1"
zone    = "us-central1-a"
}

resource "google_compute_instance" "vm_instance" {
name         = "github-actions-vm"
machine_type = "e2-micro"
zone         = "us-central1-a"

boot_disk {
initialize_params {
image = "debian-cloud/debian-12"
size  = 10
}
}

network_interface {
network = "default"

```
access_config {
}
```

}

tags = ["http-server"]

metadata_startup_script = <<-EOF
#!/bin/bash
apt-get update
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx
EOF

labels = {
environment = "dev"
owner       = "aishwarya"
}
}

output "instance_name" {
value = google_compute_instance.vm_instance.name
}

output "external_ip" {
value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
