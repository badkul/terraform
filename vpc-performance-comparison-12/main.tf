resource "google_compute_instance" "small_vm" {
  name         = "small-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOF
    apt update
    apt install -y iperf3
  EOF
}

resource "google_compute_instance" "large_vm" {
  name         = "large-vm"
  machine_type = "e2-standard-2"
  zone         = "us-central1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOF
    apt update
    apt install -y iperf3
  EOF
}

resource "google_compute_instance" "premium_vm" {
  name         = "premium-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-f"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
      network_tier = "PREMIUM"
    }
  }
}

resource "google_compute_instance" "standard_vm" {
  name         = "standard-vm"
  machine_type = "e2-micro"
  zone         = "us-central1-f"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
      network_tier = "STANDARD"
    }
  }
}