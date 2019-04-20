resource "vsphere_virtual_machine" "vms" {
  count               = "${length(keys(var.vms))}"
  name                = "${element(keys(var.vms),count.index)}"
  datastore_id        = "${var.ds_id}"
  resource_pool_id    = "${var.rp_id}"
  num_cpus            = "${var.vm_cpus}"
  memory              = "${var.vm_mem}"
  guest_id            = "${var.guest_id}"
  folder              = "${var.vs_vm_folder}"
  latency_sensitivity = "normal"
  scsi_type           = "${var.template_scsi_type}"
  nested_hv_enabled   = "${var.hv_enabled}"

  disk {
    label            = "disk0"
    size             = "${var.vm_disk_size}"
    eagerly_scrub    = "${var.template_disk_es}"
    thin_provisioned = "${var.template_disk_tp}"
  }

  network_interface {
    network_id   = "${var.net_id}"
    adapter_type = "${var.adapter_type}"
  }

  clone {
    template_uuid = "${var.template_id}"

    customize {
      timeout = 20

      linux_options {
        host_name = "${element(keys(var.vms),count.index)}"
        domain    = "${var.domain}"
        time_zone = "${var.time_zone}"
      }

      network_interface {
        ipv4_address = "${element(values(var.vms),count.index)}"
        ipv4_netmask = "${var.ip_netmask}"
      }

      dns_server_list = "${var.dns_servers}"
      dns_suffix_list = ["${var.domain}"]
      ipv4_gateway    = "${var.ip_gateway}"
    }
  }
}
