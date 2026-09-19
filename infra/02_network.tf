# ./infra/02_network.tf

resource "yandex_vpc_network" "main" {
  description = "Основная VPC-сеть для потока ${var.flow}"
  name        = "${var.flow}-vpc"
}

resource "yandex_vpc_subnet" "public" {
  description    = "Публичная подсеть для доступа в интернет"
  name           = "${var.flow}-public"
  zone           = var.zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "public_b" {
  description    = "Публичная подсеть для доступа в интернет"
  name           = "${var.flow}-public-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "public_d" {
  description    = "Публичная подсеть для доступа в интернет"
  name           = "${var.flow}-public-d"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}

resource "yandex_vpc_subnet" "private" {
  description    = "Приватная подсеть с маршрутизацией через NAT"
  name           = "${var.flow}-private"
  zone           = var.zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.110.0/24"]
  route_table_id = yandex_vpc_route_table.nat_route_private.id
}

resource "yandex_vpc_subnet" "private_b" {
  description    = "Приватная подсеть в зоне ru-central1-b"
  name           = "${var.flow}-private-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.120.0/24"]
}

resource "yandex_vpc_subnet" "private_d" {
  description    = "Приватная подсеть в зоне ru-central1-d"
  name           = "${var.flow}-private-d"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.130.0/24"]
}

resource "yandex_vpc_route_table" "nat_route_private" {
  description = "Маршрутизация исходящего трафика приватной подсети через NAT-инстанс"
  name        = "${var.flow}-nat-instance-route"
  network_id  = yandex_vpc_network.main.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}