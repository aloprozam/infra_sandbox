rovider "libvirt" {
  uri = "qemu+ssh://root@20.20.20.191/system"
}


variable "domain_name" {
  type    = string
  default = "vm-node-01"
}
