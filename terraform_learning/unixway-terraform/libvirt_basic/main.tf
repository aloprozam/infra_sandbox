resource "libvirt_network" "olymp_lan" {
  name = "olymp_lan"

  autostart = true
  mode      = "nat"
  domain    = "olympus.local"
  addresses = ["10.17.3.0/24"]

  dns {
    enabled    = true
    local_only = true
  }
}

resource "libvirt_cloudinit_disk" "olymp_cloudinit" {
  name           = "olymp_cloudinit"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.olymp_pool.name
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/cloudinit/user_data.cfg")
  vars = {
    domain_name = var.domain_name
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/templates/cloudinit/network_config.cfg")
}

resource "libvirt_pool" "olymp_pool" {
  name = "olymp_pool"
  type = "dir"
  path = "/QEMU/olymp_pool"
}

resource "libvirt_volume" "olymp_volume" {
  name   = "olymp_volume"
  pool   = libvirt_pool.olymp_pool.name
  source = "https://cloud.debian.org/images/cloud/sid/daily/latest/debian-sid-genericcloud-amd64-daily.qcow2"
  format = "qcow2"
}

resource "libvirt_domain" "olymp_vm" {
  name      = "olymp_vm"
  memory    = "2048"
  vcpu      = 2
  running   = true
  cloudinit = libvirt_cloudinit_disk.olymp_cloudinit.id

  network_interface {
    network_id     = libvirt_network.olymp_lan.id
    wait_for_lease = false
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.olymp_volume.id
  }
}