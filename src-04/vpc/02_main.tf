### src-04/vpc/02_main.tf

resource "yandex_vpc_network" "vpc" {
  name = var.env_name
}

resource "yandex_vpc_subnet" "vpc" {
  name           = var.env_name
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = [var.v4_cidr_blocks]
}