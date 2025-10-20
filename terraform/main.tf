#main.tf template per proxmox

terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.2-rc03"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://<ip-address>:8006/api2/json"
  pm_api_token_id = <tuo-token-id>
  pm_api_token_secret = <token-secret>
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "VM" {
  name         = "VM"
  target_node  = "pve"
  clone        = "VM-macchina"
  vmid         = 420
  full_clone   = true

  agent        = 1

  cores        = 2
  memory       = 2048
  os_type     = "cloud-init"

  scsihw       = "virtio-scsi-pci" # Matches your template
  cpu_type     = "host"
  vcpus        = 0

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
     scsi {
      scsi0 {
        disk {
          size         = "32G" 
          storage      = "local-lvm"
          cache        = "writeback"
          discard      = true
        }
      }
    }
}


 network {
    id         = 0
    model      = "virtio"
    bridge     = "vmbr0"
  }

  ciuser = "user"
  cipassword = "password"

  ipconfig0   = "ip=192.168.1.128/24,gw=192.168.1.1" #cambia 

  sshkeys = <<EOF
  ssh-rsa <tua-chiave> <tuo-utente>@<tuo-host>
  EOF

}
