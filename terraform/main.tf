terraform {
  # terraform version
  required_version = ">=0.12.0"
}

provider "google" {
  # provider version
  version = "~> 3.0"

  # Project ID
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "app" {
  count        = var.instance_count
  name         = "reddit-app-${count.index + 1}"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.app_ip.address
    }
  }

  metadata = {
    # path to public ssh-key
    ssh-keys = "appuser:${file(var.public_key_path)}\nappuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}\nappuser3:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].access_config[0].nat_ip
    user  = "appuser"
    agent = false
    # path to private ssh-key
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

}



resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  # network name, for which or rule will apply
  network = "default"
  # what kind of access we want to enable
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  # network ip or mask to grant access
  source_ranges = ["0.0.0.0/0"]
  # target tags where this firewall rule should work
  target_tags = ["reddit-app"]
}

resource "google_compute_firewall" "firewall_ssh" {
  name = "default-allow-ssh"
  description = "Allow SSH from anywhere"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["reddit-app"]
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
