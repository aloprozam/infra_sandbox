provider "libvirt" {
  uri = "qemu+ssh://root@20.20.20.191/system"
}

variable "domains_list" {
  default = {
    "iceberg" = {
      "domain_ip"        = "192.168.35.20"
      "os_root_disk_url" = "https://cloud.debian.org/images/cloud/sid/daily/latest/debian-sid-genericcloud-amd64-daily.qcow2"
      "domain_user"      = "ubuntu"
      "domain_password"  = "$5$SSwuCpHb$cia.MM7I.J7wrR4JEh1AgfEbJhPC6wH.1L9pXxdxL8A"
    }
  }
}

variable "domain_memory" {
  type    = string
  default = "2048"
}

variable "domain_vcpu" {
  type    = string
  default = "2"
}

variable "network_address" {
  type    = string
  default = "192.168.35.0"
}

variable "network_gate" {
  type    = string
  default = "192.168.35.1"
}

variable "network_mask" {
  type    = string
  default = "24"
}

variable "network_name" {
  type    = string
  default = "olymp_terra_lan"
}

variable "network_zone" {
  type    = string
  default = "olympus.local"
}

variable "network_mode" {
  type    = string
  default = "nat"
}