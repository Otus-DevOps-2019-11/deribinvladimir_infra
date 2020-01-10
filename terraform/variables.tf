variable project {
  description = "Project ID"
}
# we can add description and default value, but this is optional
variable region {
  description = "Region"
  default = "europe-west1"
}
variable zone {
  description = "Zone"
  default     = "europe-west1-c"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable disk_image {
  description = "Disk image"
}
variable instance_count {
  description = "Number of instances"
  default     = "1"
}

# terraform-2
variable app_disk_image {
  description = "Disk image for reddit app"
  default = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db-base"
}
