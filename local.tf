locals {
    vms = [
        for vm in var.vms : {
            ip          = lookup(port, "ip", "dhcp")
            external    = lookup(vm, "vmid", 200)
            gw          = lookup(vm, "gw", "192.168.0.1")
        }
    ]
}