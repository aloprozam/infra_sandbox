locals {
  network_full_addr = format("%s/%s", var.network_address, var.network_mask)
}
resource "libvirt_network" "network" {
  name = var.network_name

  autostart = true
  mode      = var.network_mode
  domain    = var.network_zone
  addresses = ["${local.network_full_addr}"]

  dns {
    enabled    = true
    local_only = true
  }
}