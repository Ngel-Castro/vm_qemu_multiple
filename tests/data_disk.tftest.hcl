# Plan-only tests with a mocked provider: nothing here talks to Proxmox.

mock_provider "proxmox" {}

variables {
  proxmox_token_secret = "not-a-secret"
}

run "no_data_disk_by_default" {
  command = plan

  variables {
    vms = [{
      name = "a", target_node = "n", storage = "local-lvm", storage_size = 40,
      full_clone = true, template_name = "t", network_bridge = "vmbr0",
      memory = 2048, cores = 2, tags = "tofu"
    }]
  }

  assert {
    condition     = length(proxmox_vm_qemu.vm["0"].disks[0].scsi[0].scsi1) == 0
    error_message = "scsi1 must not exist when data_disk_size is 0"
  }
}

run "data_disk_on_the_vm_storage" {
  command = plan

  variables {
    vms = [{
      name = "a", target_node = "n", storage = "local-lvm", storage_size = 40,
      full_clone = true, template_name = "t", network_bridge = "vmbr0",
      memory = 2048, cores = 2, tags = "tofu", data_disk_size = 100
    }]
  }

  assert {
    condition     = proxmox_vm_qemu.vm["0"].disks[0].scsi[0].scsi1[0].disk[0].size == "100"
    error_message = "scsi1 must be 100 GB"
  }
  assert {
    condition     = proxmox_vm_qemu.vm["0"].disks[0].scsi[0].scsi1[0].disk[0].storage == "local-lvm"
    error_message = "the data disk defaults to the VM's storage"
  }
  assert {
    condition     = proxmox_vm_qemu.vm["0"].disks[0].scsi[0].scsi0[0].disk[0].size == "40"
    error_message = "the root disk keeps storage_size"
  }
}

run "data_disk_on_its_own_storage" {
  command = plan

  variables {
    vms = [{
      name = "a", target_node = "n", storage = "local-lvm", storage_size = 40,
      full_clone = true, template_name = "t", network_bridge = "vmbr0",
      memory = 2048, cores = 2, tags = "tofu", data_disk_size = 100, data_disk_storage = "big"
    }]
  }

  assert {
    condition     = proxmox_vm_qemu.vm["0"].disks[0].scsi[0].scsi1[0].disk[0].storage == "big"
    error_message = "data_disk_storage must win"
  }
}
