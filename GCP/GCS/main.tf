terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("C:/Users/VENUGOPAL/venu-6766-78f56d92bdda.json")

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_storage_bucket" "GCP" {
  name          = "venu6766"
  location      = "EU"
  force_destroy = true

}