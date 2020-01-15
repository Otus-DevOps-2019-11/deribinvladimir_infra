terraform {
  backend "gcs" {
    bucket = "storage-bucket-olololo12345"
    prefix = "tf-state-stage"
  }
}
