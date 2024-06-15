vms = [
    { 
        name            = "vm-1"
        target_node     = "proxmox"
        storage         = "Kingstone-data"
        storage_size    = 32
        full_clone      = true
        template_name   = "ubuntu-server-beta"
        network_bridge  = "vmbr0"
        memory          = 2048
        cores           = 2
        tags            = "tofu"
        ip              = "192.168.0.200/24"
        vmid            = 200
        gw              = "192.168.0.1"
    },
    { 
        name            = "vm-2"
        target_node     = "proxmox"
        storage         = "Kingstone-data"
        storage_size    = 32
        full_clone      = true
        template_name   = "ubuntu-server-beta"
        network_bridge  = "vmbr0"
        memory          = 2048
        cores           = 2
        tags            = "tofu"
        ip              = "192.168.0.201/24"
        vmid            = 201
        gw              = "192.168.0.1"
    }
]
environment       = "dev"
default_password  = "LXCChangeMe"