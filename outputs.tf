output "vm_vmids" {
  value = { for k, v in proxmox_vm_qemu.vm : k => v.id }
}

output "vm_ips" {
  value = { for k, v in proxmox_vm_qemu.vm : k => v.default_ipv4_address }
}