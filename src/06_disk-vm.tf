variable "storage_config" {
  description = "Параметры для storage"
  type = object({
    cpu             = number
    ram             = number
    disk_volume     = number
    image_id        = string
  })
  default = {
    cpu             = 2
    ram             = 2
    disk_volume     = 10
    image_id        = "fd8cdbtd9eepnmm4gpne"
  }
}

resource "yandex_compute_disk" "storage_disk" {
  count = 3
  name     = "storage-disk-${count.index + 1}"
  type     = "network-hdd"
  zone     = var.default_zone
  size     = 1
  block_size = 4096
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores         = var.storage_config.cpu
    memory        = var.storage_config.ram
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.storage_config.image_id
      size     = var.storage_config.disk_volume
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

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disk[*].id
    content {
      disk_id = secondary_disk.value
    }
  }
}