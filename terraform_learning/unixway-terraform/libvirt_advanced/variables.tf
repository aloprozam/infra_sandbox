provider "libvirt" {
  uri = "qemu+ssh://root@20.20.20.191/system"
}

variable "os_root_disk_url" {
  type    = string
  default = "https://cloud.debian.org/images/cloud/sid/daily/latest/debian-sid-genericcloud-amd64-daily.qcow2"
}
variable "domain_name" {
  type    = string
  default = "vm-node"
}

variable "domain_memory" {
  type    = string
  default = "2048"
}

variable "domain_vcpu" {
  type    = string
  default = "2"
}

variable "domain_ip" {
  type    = string
  default = "192.168.35.20"
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