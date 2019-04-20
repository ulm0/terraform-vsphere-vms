# VM instances
# vSphere cluster
variable "dns_servers" {
  description = "DNS servers for VMs"
  default     = ["192.168.1.1"]
}

variable "domain" {
  description = "Search DNS domain VMs are going to be attached to"
  default     = "localdomain"
}

variable "hv_enabled" {
  description = "Enable nested hardware virtualization, required when using kata-containers"
  default     = false
}

variable "ip_gateway" {
  description = "Gateway IP for the given network"
  default     = "192.168.1.1"
}

variable "ip_netmask" {
  description = "Mask for the given network"
  default     = "24"
}

variable "vm_cpus" {
  description = "CPUs for VMs to be created"
  default     = 1
}

variable "vm_mem" {
  description = "Memory in MBs for VMs to be created"
  default     = 2048
}

variable "vm_disk_size" {
  # Defaults cannot contain interpolations ATM
  # https://github.com/hashicorp/terraform/issues/14343
  # default = "${module.vsphere.template_disk_size}"
  description = "Disk size in GBs for VMs to be created."

  default = ""
}

variable "vms" {
  description = "Key-value list containing VM names and IPs"
  type        = "map"
}

# interpolation in source not supported yet
# see: https://github.com/hashicorp/terraform/issues/1439
# variable "ref" {default = "master"}

variable "time_zone" {
  description = "Timezone to be set in VMs"
  default     = "UTC"
}

variable "vm_template_name" {
  description = "Template to use for VMs"
}

variable "vs_cluster_name" {
  description = "vSphere cluster to deploy VMs to"
}

variable "vs_dc_name" {
  description = "vSphere datacenter to deploy VMs to"
}

variable "vs_ds_name" {
  description = "vSphere datastore to deploy VMs to"
}

variable "vs_hosts" {
  description = "vSphere hosts list to deploy VMs to"
  default     = []
}

variable "vs_network_name" {
  description = "vSphere network to attach VMs to"
  default     = "VM Network"
}

variable "vs_rp_name" {
  description = "vSphere resource pool to deploy VMs to"
}

variable "vs_vm_folder" {
  description = "vSphere folder to place VMs in"
}

locals {
  disk_size        = "${module.vsphere.template_disk_size}"
  master_disk_size = "${var.master_disk_size != "" ? var.master_disk_size : local.disk_size}"
  worker_disk_size = "${var.worker_disk_size != "" ? var.worker_disk_size : local.disk_size}"
}
