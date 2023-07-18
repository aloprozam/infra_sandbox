resource "libvirt_cloudinit_disk" "cloudinit" {
  name           = "cloudinit"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.pool.name

}

data "template_file" "user_data" {
  template = file("${path.module}/templates/cloudinit/user_data.cfg")
  vars = {
    cloudinit_hostname = replace(var.domain_ip, ".", "-")
    domain_user     = var.domain_user
    domain_password = var.domain_password
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/templates/cloudinit/network_config.cfg")
  vars = {
    domain_ip       = var.domain_ip
    network_zone    = var.network_zone
    network_gate    = var.network_gate
    network_mask    = var.network_mask
  }
}

resource "libvirt_pool" "pool" {
  name = format("%s-pool", var.domain_name)
  type = "dir"
  path = format("/QEMU/%s", var.domain_name)

}

resource "libvirt_volume" "volume" {
  name   = format("%s-root", var.domain_name)
  pool   = libvirt_pool.pool.name
  source = var.os_root_disk_url
  format = "qcow2"


}

resource "libvirt_domain" "olymp_vm" {
  name      = var.domain_name
  memory    = var.domain_memory
  vcpu      = var.domain_vcpu
  running   = true
  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  connection {
    type     = "ssh"
    user     = var.domain_user
    private_key = file("/home/aloprozam/.ssh/id_rsa")
    host     = var.domain_ip
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y qemu-guest-agent"
    ]
    on_failure = fail
  }

  timeouts {
    create = "20m"
  }

  network_interface {
    network_id     = var.domain_net_id
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
    volume_id = libvirt_volume.volume.id
  }
}