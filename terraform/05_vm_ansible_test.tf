# terraform/05_vm-ansible-test.tf

data "yandex_compute_image" "os" {
  family = "centos-stream-9-oslogin"
}

# vm-test
resource "yandex_compute_instance" "vm_ansible_test" {
  name        = "vm-ansible-test"
  hostname    = "vm-ansible-test"
  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = 4
    memory        = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.image_id
      type     = "network-hdd"
      size     = 30
    }
  }

  metadata = {
    user-data = templatefile("00_cloud-init.tpl", {
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
    security_group_ids = [yandex_vpc_security_group.docker_sg.id]
  }
}