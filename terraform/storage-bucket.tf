terraform {
  # terraform version
  required_version = ">=0.12.0"
}

provider "google" {
  # provider version
  version = "~> 2.15"

  # Project ID
  project = var.project
  region  = var.region
}

module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.0"
  name = "storage-bucket-olololo12345"
  location = var.region
}

output storage-bucket_url {
  value = module.storage-bucket.url
}
