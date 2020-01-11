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

module "app" {
  source = "./modules/app"
  public_key_path = var.public_key_path
  zone = var.zone
  app_disk_image = var.app_disk_image
}

module "db" {
  source = "./modules/db"
  public_key_path = var.public_key_path
  zone = var.zone
  db_disk_image = var.db_disk_image
}

module "vpc" {
  source = "./modules/vpc"
  # source_ranges = ["80.250.215.124/32"]
  # source_ranges = ["178.66.2.16/32"]
}
