resource "google_compute_route" "custom_route_via_vm" {
  name    = "route-via-router-vm"
  network = data.google_compute_network.existing_vpc.id

  dest_range        = "0.0.0.0/0"
  priority          = 800   

  next_hop_instance       = data.google_compute_instance.router_vm.self_link
  next_hop_instance_zone = var.router_vm_zone

  tags = ["route-via-router"]
}

resource "google_compute_router" "cloud_router" {
  name    = "cloud-nat-router"
  network = data.google_compute_network.existing_vpc.id
  region  = var.region

  bgp {
    asn = 64514
  }
}
