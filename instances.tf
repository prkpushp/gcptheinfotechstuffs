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
    # Add your startup script commands here
  EOF
}



resource "google_compute_instance" "windows_public_instance" {
  name         = "windows-public-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-c"
  boot_disk {
    initialize_params {
      image = "windows-server-2022-dc-v20230510"
    }
  }

  network_interface {
    network       = google_compute_network.my_network.id
    subnetwork    = google_compute_subnetwork.windows_subnet.name
    access_config {
      nat_ip = google_compute_address.windows_public_ip.address
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    # Add your startup script commands here
  EOF
}