## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 3.0.2-rc07 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 3.0.2-rc07 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.vm](https://registry.terraform.io/providers/telmate/proxmox/3.0.2-rc07/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | on which enviroment the project will be running | `string` | `"dev"` | no |
| <a name="input_proxmox_host"></a> [proxmox\_host](#input\_proxmox\_host) | Value for proxmox cluster/server | `string` | `"https://192.168.0.131:8006/api2/json"` | no |
| <a name="input_proxmox_token_id"></a> [proxmox\_token\_id](#input\_proxmox\_token\_id) | Proxmox Token user@pam!token\_id | `string` | `"terraform-prov@pve!terraform"` | no |
| <a name="input_proxmox_token_secret"></a> [proxmox\_token\_secret](#input\_proxmox\_token\_secret) | Proxmox token secret | `string` | n/a | yes |
| <a name="input_vms"></a> [vms](#input\_vms) | List of VM definitions to create. `ip` defaults to `"dhcp"`. `vlan_tag` defaults to `3`. Omit `gw` when using DHCP. | <pre>list(object({<br>        name           = string<br>        target_node    = string<br>        storage        = string<br>        storage_size   = number<br>        full_clone     = bool<br>        template_name  = string<br>        network_bridge = string<br>        memory         = number<br>        cores          = number<br>        tags           = string<br>        ip             = optional(string, "dhcp")<br>        vmid           = optional(number, null)<br>        gw             = optional(string, null)<br>        vlan_tag       = optional(number, 3)<br>    }))</pre> | <pre>[<br>  {<br>    "cores": 2,<br>    "full_clone": true,<br>    "memory": 2048,<br>    "name": "vm",<br>    "network_bridge": "vmbr0",<br>    "storage": "Kingstone-data",<br>    "storage_size": 32,<br>    "tags": "tofu",<br>    "target_node": "proxmox",<br>    "template_name": "ubuntu-server-beta",<br>    "vlan_tag": 3<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_ips"></a> [vm\_ips](#output\_vm\_ips) | Map of VM key to default IPv4 address reported by the QEMU guest agent. |
| <a name="output_vm_vmids"></a> [vm\_vmids](#output\_vm\_vmids) | Map of VM key to Proxmox VM ID. |
