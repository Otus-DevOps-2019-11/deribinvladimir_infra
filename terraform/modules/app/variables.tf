variable zone {
  description = "Zone"
  default     = "europe-west1-c"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
  default     = "~/.ssh/appuser.pub"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
  default     = "~/.ssh/appuser"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable "reddit_internal_ip" {
  description = "Reddit DB internal ip"
}

variable provision_enabled {
  default = "false"
}
