variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
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
  default     = "reddit-app-base-1517429032"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base-1517429294"
}

variable "db_port" {
  default     = "27017"
  description = "Database port"
}
