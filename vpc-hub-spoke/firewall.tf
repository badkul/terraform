resource "google_compute_firewall" "allow_hub_spokes" {
  name    = "allow-hub-spokes"
  network = google_compute_network.hub_vpc.id

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    "10.20.0.0/16",
    "10.30.0.0/16"
  ]
}

resource "google_compute_firewall" "allow_spoke_to_hub" {
  name    = "allow-spoke-to-hub"
  network = google_compute_network.spoke1.id

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.10.0.0/16"]
}

resource "google_compute_firewall" "allow_spoke2_to_hub" {
  name    = "allow-spoke2-to-hub"
  network = google_compute_network.spoke2.id

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.10.0.0/16"]
}

