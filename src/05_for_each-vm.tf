variable "each_vm" {
  description = "Список параметров для машин баз данных (main и replica)"
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
    image_id    = string
  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 4
      disk_volume = 20
      image_id    = "fd8cdbtd9eepnmm4gpne"
    },
    {
      vm_name     = "replica"
      cpu         = 4
      ram         = 8
      disk_volume = 30
      image_id    = "fd8cdbtd9eepnmm4gpne"
    }
  ]
}

resource "yandex_compute_instance" "db" {
  for_each = { for vm in var.each_vm : vm.vm_name => vm }

  name        = each.value.vm_name
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = each.value.image_id
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.public_ssh_key}"
  }
}