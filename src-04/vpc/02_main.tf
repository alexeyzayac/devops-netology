### src-04/vpc/02_main.tf

resource "yandex_vpc_network" "vpc_module" {
  name = var.env_name
}

resource "yandex_vpc_subnet" "subnet_vpc_module" {
  for_each = { for idx, s in var.subnets : idx => s }

  name           = "${var.env_name}-${each.value.zone}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.vpc_module.id
  v4_cidr_blocks = [each.value.cidr]
}