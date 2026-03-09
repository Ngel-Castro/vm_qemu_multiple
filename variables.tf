variable "vms" {
    type = list(object({
        name            = string
        target_node     = string
        storage         = string
        storage_size    = number
        full_clone      = bool
        template_name   = string
        network_bridge  = string
        memory          = number
        cores           = number
        tags            = string
        ip              = optional(string, "dhcp")
        vmid            = optional(number, null)
        gw              = optional(string, null)
        vlan_tag        = optional(number, 3)
    }))

    validation {
        condition = alltrue([
            for vm in var.vms :
            vm.ip == "dhcp" || (vm.ip != "dhcp" && vm.gw != null)
        ])
        error_message = "Each VM with a static IP must also provide a 'gw' (gateway). Set ip = \"dhcp\" to use DHCP, or provide both 'ip' and 'gw' for a static configuration."
    }

    default = [
        {
            name            = "vm"
            target_node     = "proxmox"
            storage         = "Kingstone-data"
            storage_size    = 32
            full_clone      = true
            template_name   = "ubuntu-server-beta"
            network_bridge  = "vmbr0"
            memory          = 2048
            cores           = 2
            tags            = "tofu"
            vlan_tag        = 3
        }
    ]
}

variable "proxmox_host" {
  description = "Value for proxmox cluster/server"
  type        = string
  default     = "https://192.168.0.131:8006/api2/json"
}

variable "proxmox_token_id" {
  description = "Proxmox Token user@pam!token_id"
  type        = string
  default     = "terraform-prov@pve!terraform"
}

variable "proxmox_token_secret" {
  description = "Proxmox token secret"
  type        = string
}

variable "environment" {
  description = "on which enviroment the project will be running"
  type        = string
  default     = "dev"
}
