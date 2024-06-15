output "vm_vmids" {
  value = { for k, v in proxmox_lxc.vm : k => v.vmid }
}

output "vm_ips" {
  value = { for k, v in proxmox_lxc.vm : k => v.network[0].ip }
}