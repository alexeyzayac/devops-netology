# ./terraform/03_security_group.tf

resource "yandex_vpc_security_group" "nat_sg" {
  description = "Security group для NAT-инстанса: исходящий интернет и входящие сервисные порты"
  name        = "nat-instance-sg"
  network_id  = yandex_vpc_network.main.id

  egress {
    protocol       = "ANY"
    description    = "Разрешить весь исходящий трафик NAT-инстанса в интернет"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "SSH-доступ для администрирования NAT-инстанса"
    port           = 22
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "HTTP-доступ к NAT-инстансу (прокси/веб-сервер)"
    port           = 80
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "HTTPS-доступ к NAT-инстансу (прокси/веб-сервер)"
    port           = 443
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_instance" "nat_instance" {
  name        = "nat-instance"
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