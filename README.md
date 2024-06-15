## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 3.0.1-rc1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 3.0.1-rc1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_vm_qemu.vm](https://registry.terraform.io/providers/telmate/proxmox/3.0.1-rc1/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_password"></a> [default\_password](#input\_default\_password) | Default LXC vm password | `string` | `"changeme"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | on which enviroment the project will be running | `string` | `"dev"` | no |
| <a name="input_proxmox_host"></a> [proxmox\_host](#input\_proxmox\_host) | Value for proxmox cluster/server | `string` | `"https://192.168.0.131:8006/api2/json"` | no |
| <a name="input_proxmox_token_id"></a> [proxmox\_token\_id](#input\_proxmox\_token\_id) | Proxmox Token user@pam!token\_id | `string` | `"terraform-prov@pve!terraform"` | no |
| <a name="input_proxmox_token_secret"></a> [proxmox\_token\_secret](#input\_proxmox\_token\_secret) | Proxmox token secret | `string` | n/a | yes |
| <a name="input_vms"></a> [vms](#input\_vms) | n/a | <pre>list(object({<br>        name = string<br>        target_node = string<br>        storage = string<br>        storage_size = string<br>        full_clone = bool<br>        template_name = string<br>        network_bridge = string<br>        memory = number<br>        cores  = number<br>        unprivileged = bool<br>        tags = string<br>        ip   = string<br>        vmid = number<br>        gw   = string<br>    }))</pre> | <pre>[<br>  {<br>    "cores": 2,<br>    "full_clone": true,<br>    "gw": "192.168.0.1",<br>    "ip": "192.168.0.200/24",<br>    "memory": 2048,<br>    "name": "vm",<br>    "network_bridge": "vmbr0",<br>    "storage": "Kingstone-data",<br>    "storage_size": "10G",<br>    "tags": "tofu",<br>    "target_node": "proxmox",<br>    "template_name": "samsung-ssd:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst",<br>    "unprivileged": true,<br>    "vmid": 200<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_ips"></a> [vm\_ips](#output\_vm\_ips) | n/a |
| <a name="output_vm_vmids"></a> [vm\_vmids](#output\_vm\_vmids) | n/a |
