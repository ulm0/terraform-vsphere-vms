terraform {
  required_version = ">= 0.11.0"
}

module "vsphere" {
  # interpolation in source not supported yet
  # see: https://github.com/hashicorp/terraform/issues/1439
  # source = "git::https://gitlab.com/ulm0/vsphere-vms.git//modules/vsphere?ref=${var.ref}"
  source = "./modules/vsphere"

  vm_template_name = "${var.vm_template_name}"
  vs_cluster_name  = "${var.vs_cluster_name}"
  vs_dc_name       = "${var.vs_dc_name}"
  vs_ds_name       = "${var.vs_ds_name}"
  vs_hosts         = "${var.vs_hosts}"
  vs_network_name  = "${var.vs_network_name}"
  vs_rp_name       = "${var.vs_rp_name}"
}

module "vms" {
  # interpolation in source not supported yet
  # see: https://github.com/hashicorp/terraform/issues/1439
  # source = "git::https://gitlab.com/ulm0/vsphere-vms.git//modules/vms?ref=${var.ref}"
  source = "./modules/vms"

  adapter_type       = "${module.vsphere.interface_type_ids[0]}"
  dns_servers        = "${var.dns_servers}"
  domain             = "${var.domain}"
  ds_id              = "${module.vsphere.ds_id}"
  guest_id           = "${module.vsphere.template_guest_id}"
  hv_enabled         = "${var.hv_enabled}"
  ip_gateway         = "${var.ip_gateway}"
  ip_netmask         = "${var.ip_netmask}"
  net_id             = "${module.vsphere.net_id}"
  rp_id              = "${module.vsphere.rp_id}"
  template_disk_es   = "${module.vsphere.template_disk_es}"
  template_disk_tp   = "${module.vsphere.template_disk_tp}"
  template_id        = "${module.vsphere.template_id}"
  template_scsi_type = "${module.vsphere.template_scsi_type}"
  time_zone          = "${var.time_zone}"
  vm_cpus            = "${var.vm_cpus}"
  vm_disk_size       = "${local.vm_disk_size}"
  vm_mem             = "${var.vm_mem}"
  vms                = "${var.vms}"
  vs_vm_folder       = "${var.vs_vm_folder}"
}
