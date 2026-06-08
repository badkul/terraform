resource "google_compute_disk" "disk_from_snapshot" {
  name = "disk-from-snapshot"
  zone = "us-central1-a"
  snapshot = google_compute_snapshot.boot_snapshot.id
  type     = "pd-balanced"
}