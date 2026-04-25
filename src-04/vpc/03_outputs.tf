### src-04/vpc/03_outputs.tf

output "network_id" {
  description = "ID созданной сети"
  value       = yandex_vpc_network.vpc_module.id
}

output "subnet_ids" {
  description = "Map индексов -> ID подсетей"
  value       = { for k, subnet_vpc_module in yandex_vpc_subnet.subnet_vpc_module : k => subnet_vpc_module.id }
}

output "subnet_id" {
  description = "ID первой подсети (для обратной совместимости)"
  value       = values(yandex_vpc_subnet.subnet_vpc_module)[0].id
}