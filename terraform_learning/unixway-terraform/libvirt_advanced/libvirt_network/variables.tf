variable "network_name" {}
variable "network_gate" {}
variable "network_address" {}
variable "network_mask" {}
variable "network_zone" {}
variable "network_mode" {}

terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
    archive  = { version = "2.2.0" }
    template = { version = "2.2.0" }
  }
}