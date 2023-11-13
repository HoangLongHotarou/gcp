packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

source "googlecompute" "nginx-project" {
  image_name = "packer-nginx-ubuntu-image-{{timestamp}}"
  image_description = "nginx-ubuntu-image-{{timestamp}}"
  project_id   = "adept-now-400809"
  source_image_family = "ubuntu-2204-lts"
  zone         = "us-central1-a"
  ssh_username  = "root"
  subnetwork = "managementsubnet-us"
  account_file = "./path.json"
}

build {
  name = "nginx-ubuntu-image"

  sources = ["sources.googlecompute.nginx-project"]

  provisioner "file" {
    source = "html5up.zip"
    destination = "/tmp/html5up.zip"
  }

  provisioner "shell" {
    scripts = [
      "./scripts/install.sh",
      "./scripts/setup.sh"
    ]
  }
}
