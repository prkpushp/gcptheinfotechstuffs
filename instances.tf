resource "google_compute_address" "theinfotechstuffs_public_ip" {
  name         = "theinfotechstuffs-public-ip"
  address_type = "EXTERNAL"
}
resource "google_compute_instance" "theinfotechstuffs_instance" {
  name         = "theinfotechstuffs"
  machine_type = "n1-standard-1"
  zone         = "us-central1-b"
  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20230509"
    }
  }

  network_interface {
    network       = google_compute_network.my_network.id
    subnetwork    = google_compute_subnetwork.theinfotechstuffs_subnet.name
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2
  EOF
}
