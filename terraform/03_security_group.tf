# 03_security_group.tf

# Настройка сервера bastion
resource "yandex_vpc_security_group" "netology_sg" {
  name       = "netology-sg-${var.flow}"
  network_id = yandex_vpc_network.develop.id

  ingress {
    description    = "SSH from internet"
    protocol       = "TCP"
    port           = 22
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