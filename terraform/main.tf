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
