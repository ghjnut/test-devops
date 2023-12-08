resource "google_compute_network" "default" {
  name                    = "test"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name          = "test"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-west1"
  network       = google_compute_network.default.id
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "f1-micro"
  zone         = "us-west1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.default.id
  }
}
