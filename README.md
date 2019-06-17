# vSphere VMs

Create vSphere VMs in bulk from VM template with terraform

- Master branch contains module for terraform 0.12 and later 
    ```hcl
    module "vms" {
      source = "git::https://gitlab.com/bennuteam/vsphere-vms.git"

      ...
    }
    ```
- [0.11](https://gitlab.com/bennuteam/vsphere-vms/tags/0.11): Module for terraform 0.11.x
    ```hcl
    module "vms" {
      source = "git::https://gitlab.com/bennuteam/vsphere-vms.git?ref=0.11"

      ...
    }

## Config options

| Variable | Description | Required | Default |
|:---:|:---:|:---:|:---:|
| `dns_servers` | DNS servers for VMs | Y | `192.168.1.1` |
| `domain` |  Search DNS domain VMs are going to be attached to | Y | `localdomain` |
| `enable_disk_uuid` | Enable disk uuid for VMs | N | `true` |
| `hv_enabled` | Enable nested hardware virtualization | N | `false` |
| `ip_gateway` | Gateway IP for the given network | Y | `192.168.1.1` |
| `ip_netmask` | Mask for the given network | Y | `24` |
| `vm_cpus` | CPUs for VMs to be created | N | `1` |
| `vm_mem` | Memory in MBs for VMs to be created | N | `2048` |
| `vm_disk_size` | Disk size in GBs for VMs to be created | N | *Gets disk size from template* |
| `vms` | Key-value list containing VM names and IP addresses respectively| Y | `{}` |
| `time_zone` | Timezone to be set in VMs | N | `UTC` |
| `vm_template_name` | Template to use for VMs | Y | - |
| `vs_cluster_name` | vSphere cluster to deploy VMs to | Y | - |
| `vs_dc_name` | vSphere datacenter to deploy VMs to | Y | - |
| `vs_ds_name` | vSphere datastore to deploy VMs to | Y | - |
| `vs_hosts` | vSphere hosts list to deploy VMs to | Y | `[]` |
| `vs_network_name` | vSphere network to attach VMs to | Y | `VM Network` |
| `vs_rp_name` | vSphere resource pool to deploy VMs to | Y | - |
| `vs_vm_folder` | Existing vSphere folder to place VMs in | Y | - |