resource "google_compute_network" "theinfotechstuffs_network" {
  name                    = "theinfotechstuffs-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "theinfotechstuffs_subnet" {
  name          = "theinfotechstuffs-subnet"
  ip_cidr_range = "10.10.1.0/24"
  network       = google_compute_network.my_network.self_link
  region        = "us-central1"
}

resource "google_compute_firewall" "allow_ssh_theinfotechstuffs" {
  name    = "allow-ssh-theinfotechstuffs"
  network = google_compute_network.my_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}