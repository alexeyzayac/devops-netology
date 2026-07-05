### terraform/06_vm-sentry.tf

resource "yandex_compute_instance" "vm_sentry" {
  name        = "vm-sentry-${var.flow}"
  hostname    = "vm-sentry-${var.flow}"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = 16
    memory        = 32
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.toolbox.image_id
      type     = "network-ssd"
      size     = 50
    }
  }

  metadata = {
    user-data = templatefile("cloud-init/cloud-init.tpl", {
      public_key = tls_private_key.ssh.public_key_openssh
    })
    serial-port-enable = 1
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet_a.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.cluster_sg.id]
  }
}