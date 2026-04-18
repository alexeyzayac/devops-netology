resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# Первая подсеть (зона a)
resource "yandex_vpc_subnet" "develop" {
  name           = "${var.vpc_name}-web"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# Вторая подсеть (зона b) для DB ВМ
resource "yandex_vpc_subnet" "develop_db" {
  name           = "${var.vpc_name}-db" 
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family #заменено
}

#Первая ВМ (web)
resource "yandex_compute_instance" "platform" {
#  name        = var.vm_web_name #заменено
  name        = local.web_vm_name
  platform_id = var.vm_web_platform_id #заменено
  zone        = var.default_zone
  resources {
    cores         = var.vm_web_cores #заменено
    memory        = var.vm_web_memory #заменено
    core_fraction = var.vm_web_core_fraction #заменено
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible #заменено
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${file(var.vms_ssh_public_root_key)}"
  }

}

# Вторая ВМ (db)
resource "yandex_compute_instance" "platform_db" {
#  name        = var.vm_db_name
  name        = local.db_vm_name
  platform_id = var.vm_db_platform_id
  zone        = var.vm_db_zone
  
  resources {
    cores         = var.vm_db_cores
    memory        = var.vm_db_memory
    core_fraction = var.vm_db_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${file(var.vms_ssh_public_root_key)}"
  }
}