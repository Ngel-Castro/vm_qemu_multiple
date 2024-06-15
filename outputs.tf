output "vm_vmids" {
  value = { for k, v in proxmox_vm_qemu.vm : k => v.vmid }
}

output "vm_ips" {
  value = { for k, v in proxmox_vm_qemu.vm : k => v.network[0].default_ipv4_address }
}