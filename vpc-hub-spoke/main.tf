terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}


resource "google_compute_network_peering" "hub_to_spoke1" {
  name         = "hub-to-spoke1"
  network      = google_compute_network.hub_vpc.id
  peer_network = google_compute_network.spoke1.id

  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "spoke1_to_hub" {
  name         = "spoke1-to-hub"
  network      = google_compute_network.spoke1.id
  peer_network = google_compute_network.hub_vpc.id

  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "hub_to_spoke2" {
  name         = "hub-to-spoke2"
  network      = google_compute_network.hub_vpc.id
  peer_network = google_compute_network.spoke2.id

  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "spoke2_to_hub" {
  name         = "spoke2-to-hub"
  network      = google_compute_network.spoke2.id
  peer_network = google_compute_network.hub_vpc.id

  export_custom_routes = true
  import_custom_routes = true
}

