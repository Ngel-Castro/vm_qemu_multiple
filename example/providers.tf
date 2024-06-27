terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
  backend "consul" {
    address = "consul-dev.home:8500"
    scheme  = "http"
    path    = "statefiles/example"
  }
}
