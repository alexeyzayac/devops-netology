### infra/07_outputs.tf

output "vm_docker_public_ip" {
  description = "Публичный IP адрес ВМ"
  value       = yandex_compute_instance.vm-docker.network_interface[0].nat_ip_address
}

output "vm_user" {
  description = "Имя пользователя для SSH"
  value       = var.vm_user
}

output "mysql_root_password" {
  description = "Пароль root для MySQL"
  value       = random_password.mysql_root_password.result
  sensitive   = true
}

output "mysql_password" {
  description = "Пароль пользователя wordpress для MySQL"
  value       = random_password.mysql_password.result
  sensitive   = true
}

output "flow" {
  description = "Идентификатор проекта"
  value       = var.flow
}