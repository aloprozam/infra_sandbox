module "network_generator" {
  source = "./libvirt_network"

  network_address = var.network_address
  network_gate    = var.network_gate
  network_mask    = var.network_mask
  network_name    = var.network_name
  network_zone    = var.network_zone
  network_mode    = var.network_mode
}

module "vm_generator" {
  source           = "./libvirt_domain"
  domain_name      = var.domain_name
  domain_memory    = var.domain_memory
  domain_vcpu      = var.domain_vcpu
  domain_net_id    = module.network_generator.network_id
  domain_ip        = var.domain_ip
  network_gate     = var.network_gate
  network_mask     = var.network_mask
  network_zone     = var.network_zone
  os_root_disk_url = var.os_root_disk_url
}