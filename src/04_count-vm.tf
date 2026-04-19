variable "web_vm_config" {
  description = "Параметры для одинаковых машин"
  type = object({
    instances_count = number
    cpu             = number
    ram             = number
    disk_volume     = number
    image_id        = string
  })
  default = {
    instances_count = 2
    cpu             = 2
    ram             = 2
    disk_volume     = 10
    image_id        = "fd8cdbtd9eepnmm4gpne"
  }
}

resource "yandex_compute_instance" "web" {
  count = var.web_vm_config.instances_count

  name        = "web-${count.index + 1}"
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores         = var.web_vm_config.cpu
    memory        = var.web_vm_config.ram
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.web_vm_config.image_id
      size     = var.web_vm_config.disk_volume
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

  depends_on = [yandex_compute_instance.db]
}