# ./infra/03_security_group.tf

resource "yandex_vpc_security_group" "nat_sg" {
  description = "Security group для NAT-инстанса: исходящий интернет и входящие сервисные порты"
  name        = "nat-instance-sg-${var.flow}"
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

resource "yandex_vpc_security_group" "ig_sg" {
  description = "Security group для ВМ Instance Group (LAMP): HTTP + SSH + healthcheck"
  name        = "ig-lamp-sg-${var.flow}"
  network_id  = yandex_vpc_network.main.id

  egress {
    protocol       = "ANY"
    description    = "Разрешить весь исходящий"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "HTTP от балансировщика и пользователей"
    port           = 80
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "SSH-доступ для администрирования NAT-инстанса"
    port           = 22
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "mysql_sg" {
  description = "Security group для кластера MySQL"
  name        = "mysql-sg-${var.flow}"
  network_id  = yandex_vpc_network.main.id

  egress {
    protocol       = "ANY"
    description    = "Разрешить весь исходящий трафик"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "Доступ к MySQL из приватных подсетей"
    port           = 3306
    protocol       = "TCP"
    v4_cidr_blocks = ["192.168.0.0/16"]
  }
}