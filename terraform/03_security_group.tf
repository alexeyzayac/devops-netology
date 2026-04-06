# 03_security_group.tf

# Настройка сервера
resource "yandex_vpc_security_group" "netology_sg" {
  name       = "netology-sg-${var.flow}"
  network_id = yandex_vpc_network.develop.id

  ingress {
    description    = "SSH from internet"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "2377 from internet"
    protocol       = "TCP"
    port           = 2377
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description    = "5000 from internet"
    protocol       = "TCP"
    port           = 5000
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "7946 from internet"
    protocol       = "TCP"
    port           = 7946
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description    = "7946 (UDP) from internet"
    protocol       = "UDP"
    port           = 7946
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description    = "4789 from internet"
    protocol       = "UDP"
    port           = 4789
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description    = "Any outgoing"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}