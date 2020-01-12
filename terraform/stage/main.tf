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

provider "null" {
  version = "~> 2.1"
}

module "db" {
  source           = "../modules/db"
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  zone             = var.zone
  db_disk_image    = var.db_disk_image
}

module "app" {
  source             = "../modules/app"
  public_key_path    = var.public_key_path
  zone               = var.zone
  app_disk_image     = var.app_disk_image
  reddit_internal_ip = module.db.db_internal_ip
  #  db_internal_ip    = "10.156.15.193"
  provision_enabled = true
}

module "vpc" {
  source = "../modules/vpc"
  # source_ranges = ["80.250.215.124/32"]
  # source_ranges = ["178.66.2.16/32"]
}
