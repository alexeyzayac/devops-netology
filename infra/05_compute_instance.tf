# ./infra/05_compute_instance.tf

resource "yandex_compute_instance" "nat_instance" {
  name        = "nat-instance-${var.flow}"
  platform_id = "standard-v3"
  zone        = var.zone
  depends_on  = [tls_private_key.ssh]

  resources {
    cores         = var.nat_resources.cores
    memory        = var.nat_resources.memory
    core_fraction = var.nat_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_resources.image_id
      size     = var.nat_resources.hdd_size
      type     = var.nat_resources.hdd_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    ip_address         = "192.168.10.254"
    security_group_ids = [yandex_vpc_security_group.nat_sg.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${trimspace(tls_private_key.ssh.public_key_openssh)}"
  }
}

resource "yandex_compute_instance" "public_vm" {
  depends_on  = [yandex_compute_instance.nat_instance]
  name        = "vm-public-${var.flow}"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = var.public_vm_resources.cores
    memory        = var.public_vm_resources.memory
    core_fraction = var.public_vm_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.public_vm_resources.image_id
      size     = var.public_vm_resources.hdd_size
      type     = var.public_vm_resources.hdd_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${trimspace(tls_private_key.ssh.public_key_openssh)}"
  }
}

resource "yandex_compute_instance" "private_vm" {
  depends_on  = [yandex_vpc_route_table.nat_route_private]
  name        = "vm-private-${var.flow}"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = var.private_vm_resources.cores
    memory        = var.private_vm_resources.memory
    core_fraction = var.private_vm_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.private_vm_resources.image_id
      size     = var.private_vm_resources.hdd_size
      type     = var.private_vm_resources.hdd_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
  }

  metadata = {
    ssh-keys = "ubuntu:${trimspace(tls_private_key.ssh.public_key_openssh)}"
  }
}