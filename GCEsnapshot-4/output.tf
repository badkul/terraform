output "new_vm_ip" {
  value = google_compute_instance.new_vm.network_interface[0].access_config[0].nat_ip
}