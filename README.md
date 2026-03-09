# vm_qemu_multiple

OpenTofu/Terraform module for provisioning multiple QEMU VMs on Proxmox using the `telmate/proxmox` provider.

Each VM in the `vms` list can independently use **DHCP** or a **static IP** — controlled entirely by the per-VM `ip` and `gw` fields.

---

## Usage

### DHCP (default)

Omit `ip` and `gw` (or explicitly set `ip = "dhcp"`). No gateway is required.

```hcl
module "vms" {
  source = "github.com/Ngel-Castro/vm_qemu_multiple?ref=0.0.2"

  proxmox_token_secret = var.proxmox_token_secret

  vms = [
    {
      name           = "dns-server"
      target_node    = "proxmox"
      storage        = "local-lvm"
      storage_size   = 32
      full_clone     = true
      template_name  = "ubuntu-server-beta"
      network_bridge = "vmbr0"
      memory         = 2048
      cores          = 2
      tags           = "tofu"
      # ip and gw omitted → DHCP
    }
  ]
}
```

### Static IP

Provide both `ip` (CIDR notation) and `gw` (gateway). A `tofu plan` error is raised if `gw` is missing when a static IP is set.

```hcl
module "vms" {
  source = "github.com/Ngel-Castro/vm_qemu_multiple?ref=0.0.2"

  proxmox_token_secret = var.proxmox_token_secret

  vms = [
    {
      name           = "web-server"
      target_node    = "proxmox"
      storage        = "local-lvm"
      storage_size   = 32
      full_clone     = true
      template_name  = "ubuntu-server-beta"
      network_bridge = "vmbr0"
      memory         = 4096
      cores          = 4
      tags           = "tofu"
      ip             = "192.168.3.10/24"
      gw             = "192.168.3.1"
    }
  ]
}
```

### Mixed — DHCP and static in the same list

```hcl
vms = [
  {
    name           = "vm-dhcp"
    target_node    = "proxmox"
    storage        = "local-lvm"
    storage_size   = 32
    full_clone     = true
    template_name  = "ubuntu-server-beta"
    network_bridge = "vmbr0"
    memory         = 2048
    cores          = 2
    tags           = "tofu"
    # DHCP — no ip/gw needed
  },
  {
    name           = "vm-static"
    target_node    = "proxmox"
    storage        = "local-lvm"
    storage_size   = 32
    full_clone     = true
    template_name  = "ubuntu-server-beta"
    network_bridge = "vmbr0"
    memory         = 2048
    cores          = 2
    tags           = "tofu"
    ip             = "192.168.3.20/24"
    gw             = "192.168.3.1"
  }
]
```

---

## Requirements

| Name | Version |
|------|---------|
| [proxmox](https://registry.terraform.io/providers/telmate/proxmox/latest) | 3.0.2-rc07 |

## Providers

| Name | Version |
|------|---------|
| proxmox | 3.0.2-rc07 |

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.vm](https://registry.terraform.io/providers/telmate/proxmox/3.0.2-rc07/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `vms` | List of VM definitions. `ip` defaults to `"dhcp"`. When `ip` is a static CIDR, `gw` **must** be provided — a missing gateway causes a plan-time validation error. | `list(object({...}))` | see variables.tf | no |
| `environment` | Environment suffix appended to each VM name | `string` | `"dev"` | no |
| `proxmox_host` | Proxmox API URL | `string` | `"https://192.168.0.131:8006/api2/json"` | no |
| `proxmox_token_id` | Proxmox API token ID (`user@pam!token`) | `string` | `"terraform-prov@pve!terraform"` | no |
| `proxmox_token_secret` | Proxmox API token secret | `string` | — | **yes** |

### Per-VM object fields

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `name` | `string` | — | VM name (environment suffix added automatically) |
| `target_node` | `string` | — | Proxmox node name |
| `storage` | `string` | — | Storage pool name |
| `storage_size` | `number` | — | Disk size in GB |
| `full_clone` | `bool` | — | Full clone vs linked clone |
| `template_name` | `string` | — | Template to clone from |
| `network_bridge` | `string` | — | Network bridge (e.g. `vmbr0`) |
| `memory` | `number` | — | RAM in MB |
| `cores` | `number` | — | CPU core count |
| `tags` | `string` | — | Proxmox tags |
| `ip` | `string` | `"dhcp"` | CIDR address for static IP, or `"dhcp"` |
| `gw` | `string` | `null` | Gateway — **required** when `ip` is not `"dhcp"` |
| `vmid` | `number` | `null` | Proxmox VM ID (auto-assigned if null) |
| `vlan_tag` | `number` | `3` | VLAN tag |

## Outputs

| Name | Description |
|------|-------------|
| `vm_ips` | Map of VM name → IPv4 address (from QEMU guest agent) |
| `vm_vmids` | Map of VM name → Proxmox VM ID |
