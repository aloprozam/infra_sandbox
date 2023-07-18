variable "domain_name" {}
variable "domain_memory" {}
variable "domain_vcpu" {}
variable "domain_net_id" {}
variable "domain_ip" {}
variable "os_root_disk_url" {}
variable "network_gate" {}
variable "network_mask" {}
variable "network_zone" {}
variable "domain_user" {}
variable "domain_password" {}

terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
    archive  = { version = "2.2.0" }
    template = { version = "2.2.0" }
  }
}