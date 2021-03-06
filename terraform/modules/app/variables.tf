variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable app_disk_image {
  description = "Disk imape for reddit app"
  default     = "reddit-app-base"
}

variable machine_type {
  description = "Machine type"
  default     = "g1-small"
}

variable db_addr {
  default = "127.0.0.1:27017"
}
