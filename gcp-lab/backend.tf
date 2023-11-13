terraform {
  # backend "gcs" {
  #     bucket  = "tf-state-beta-314"
  #     prefix  = "terraform/state"
  # }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
