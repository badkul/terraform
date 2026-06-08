resource "google_compute_network" "vpc" {
name = "github-actions-vpc"
auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
name = "github-actions-subnet"
ip_cidr_range = "10.10.0.0/24"
region = "us-central1"
network = google_compute_network.vpc.id
}

resource "google_compute_firewall" "allow_http_ssh" {
name = "allow-http-ssh"
network = google_compute_network.vpc.name

allow {
protocol = "tcp"
ports = ["22", "80"]
}

source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm_instance" {
name = "github-actions-vm"
machine_type = "e2-micro"
zone = "us-central1-a"

boot_disk {
initialize_params {
image = "debian-cloud/debian-12"
size = 10
}
}

network_interface {
network = google_compute_network.vpc.id
subnetwork = google_compute_subnetwork.subnet.id
access_config {
}

}
}

resource "google_compute_disk" "extra_disk" {
  name = "extra-disk"
  zone = "us-central1-a"
}
