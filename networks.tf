resource "google_compute_network" "infotech_network" {
  name                    = "infotech-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "web_subnet" {
  name          = "web-subnet"
  ip_cidr_range = "10.10.1.0/24"
  network       = google_compute_network.my_network.self_link
  region        = "us-central1"
}

resource "google_compute_firewall" "allow_ssh_web" {
  name    = "allow-ssh-web"
  network = google_compute_network.my_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}