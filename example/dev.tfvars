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
    }
]
environment       = "dev"