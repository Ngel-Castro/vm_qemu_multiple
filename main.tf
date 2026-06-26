terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }

}

provider "proxmox" {
  pm_api_url              = var.proxmox_host
  pm_api_token_id         = var.proxmox_token_id
  pm_api_token_secret     = var.proxmox_token_secret
  pm_tls_insecure         = true
  pm_debug                = true
}

resource "proxmox_vm_qemu" "vm" {
  for_each = { for idx, vm in local.vms : idx => vm }

  name        = "${each.value.name}-${var.environment}"
  target_node = each.value.target_node
  memory      = each.value.memory
  cores       = each.value.cores
  scsihw      = "virtio-scsi-single"
  full_clone  = each.value.full_clone
  agent       = 1
  qemu_os     = "l26"
  tags = "${var.environment};${each.value.tags}"
  clone = each.value.template_name

  disks {
      ide {
          ide2 {
              cloudinit {
                  storage = each.value.cloudinit_storage
              }
          }
      }
      scsi {
          scsi0 {
              disk {
                  backup             = true
                  cache              = "none"
                  discard            = true
                  emulatessd         = true
                  iothread           = true
                  mbps_r_burst       = 0.0
                  mbps_r_concurrent  = 0.0
                  mbps_wr_burst      = 0.0
                  mbps_wr_concurrent = 0.0
                  replicate          = true
                  size               = each.value.storage_size
                  storage            = each.value.storage
              }
          }
      }
  }
  ipconfig0 = each.value.ip == "dhcp" ? "ip=dhcp" : "ip=${each.value.ip},gw=${each.value.gw}"

  network {
      id        = 0
      bridge    = each.value.network_bridge
      firewall  = false
      link_down = false
      model     = "virtio"
      tag       = each.value.vlan_tag
  }  

}
