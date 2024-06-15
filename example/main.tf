module "lxc_vms" {
  source = "github.com/Ngel-Castro/vm_qemu_multiple?ref=stable"

  # Pass in required variables
    proxmox_host            = var.proxmox_host
    proxmox_token_id        = var.proxmox_token_id
    proxmox_token_secret    = var.proxmox_token_secret
    vms                     = var.vms
    environment             = var.environment
    default_password        = var.default_password
}