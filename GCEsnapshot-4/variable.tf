variable "project_id" {}
variable "region" { default = "us-central1" }
variable "zone" { default = "us-central1-a" }

variable "source_vm_name" {
  description = "Existing VM name"
}

variable "snapshot_name" {
  default = "boot-disk-snapshot"
}

variable "new_vm_name" {
  default = "vm-from-snapshot"
}