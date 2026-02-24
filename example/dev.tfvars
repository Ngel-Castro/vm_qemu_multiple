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
        vlan_tag        = 3
        # ip            = "192.168.3.10/24"  # optional: omit or set "dhcp" for DHCP
        # gw            = "192.168.3.1"       # required when ip is static
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
        vlan_tag        = 3
    }
]
environment       = "dev"