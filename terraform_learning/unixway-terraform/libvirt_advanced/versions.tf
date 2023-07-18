terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
    archive  = { version = "2.2.0" }
    template = { version = "2.2.0" }
  }
}