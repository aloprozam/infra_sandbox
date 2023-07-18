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
  source = "./libvirt_domain"

  for_each         = var.domains_list
  domain_name      = each.key
  domain_memory    = var.domain_memory
  domain_vcpu      = var.domain_vcpu
  domain_user      = each.value.domain_user
  domain_password  = each.value.domain_password
  domain_net_id    = module.network_generator.network_id
  domain_ip        = each.value.domain_ip
  network_gate     = var.network_gate
  network_mask     = var.network_mask
  network_zone     = var.network_zone
  os_root_disk_url = each.value.os_root_disk_url

  depends_on = [module.network_generator]
}