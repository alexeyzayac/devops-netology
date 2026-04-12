### infra/06_vm-docker.tf

resource "yandex_compute_instance" "vm-docker" {
  name        = "vm-docker"
  hostname    = "vm-docker"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = 4
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.toolbox.image_id
      type     = "network-hdd"
      size     = 30
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