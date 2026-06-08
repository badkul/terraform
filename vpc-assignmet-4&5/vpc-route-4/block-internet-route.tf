resource "google_compute_route" "block_internet" {
  name    = "block-internet-egress"
  network = data.google_compute_network.existing_vpc.id

  dest_range        = "0.0.0.0/0"
  priority          = 900   # higher priority than default (1000)

  next_hop_gateway = "default-internet-gateway"

  tags = ["no-internet"]
}