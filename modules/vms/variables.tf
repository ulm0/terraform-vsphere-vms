variable "adapter_type" {}

variable "dns_servers" {
  type = "list"
}

variable "domain" {}
variable "ds_id" {}
variable "guest_id" {}

variable "hv_enabled" {
  description = "Enable nested hardware virtualization"
}

variable "ip_gateway" {}
variable "ip_netmask" {}
variable "net_id" {}
variable "rp_id" {}
variable "template_disk_es" {}
variable "template_disk_tp" {}
variable "template_id" {}
variable "template_scsi_type" {}
variable "time_zone" {}
variable "vm_cpus" {}
variable "vm_disk_size" {}
variable "vm_mem" {}

variable "vms" {
  type = "map"
}

variable "vs_vm_folder" {}
