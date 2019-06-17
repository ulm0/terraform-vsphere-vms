resource "vsphere_tag_category" "vms-category" {
  name        = "terraform-vms"
  cardinality = "SINGLE"
  description = "VMs managed by Terraform"

  associable_types = [
    "VirtualMachine",
  ]
}

resource "vsphere_tag" "vm-tag" {
  name        = "terraform-vm"
  category_id = vsphere_tag_category.vms-category.id
  description = "VM managed by Terraform"
}

resource "vsphere_virtual_machine" "vms" {
  count               = length(keys(var.vms))
  datastore_id        = var.ds_id
  enable_disk_uuid    = var.enable_disk_uuid
  folder              = var.vs_vm_folder
  guest_id            = var.guest_id
  latency_sensitivity = "normal"
  memory              = var.vm_mem
  name                = element(keys(var.vms), count.index)
  nested_hv_enabled   = var.hv_enabled
  num_cpus            = var.vm_cpus
  resource_pool_id    = var.rp_id
  scsi_type           = var.template_scsi_type
  tags                = [vsphere_tag.vm-tag.id]

  disk {
    eagerly_scrub    = var.template_disk_es
    label            = "disk0"
    size             = var.vm_disk_size
    thin_provisioned = var.template_disk_tp
  }

  network_interface {
    adapter_type = var.adapter_type
    network_id   = var.net_id
  }

  clone {
    template_uuid = var.template_id

    customize {
      timeout = 20

      linux_options {
        domain    = var.domain
        host_name = element(keys(var.vms), count.index)
        time_zone = var.time_zone
      }

      network_interface {
        ipv4_address = element(values(var.vms), count.index)
        ipv4_netmask = var.ip_netmask
      }

      dns_server_list = var.dns_servers
      dns_suffix_list = [var.domain]
      ipv4_gateway    = var.ip_gateway
    }
  }
}

