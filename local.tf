locals {
  vms = [
    for vm in var.vms : {
        name            = vm.name
        target_node     = vm.target_node
        storage         = vm.storage
        storage_size    = vm.storage_size
        full_clone      = vm.full_clone
        template_name   = vm.template_name
        network_bridge  = vm.network_bridge
        memory          = vm.memory
        cores           = vm.cores
        tags            = vm.tags
        ip              = vm.ip
        vmid            = vm.vmid
        gw              = vm.gw
        vlan_tag        = vm.vlan_tag
    }
  ]
}
