output "container_name" {
  description = "Имя запущенного контейнера"
  value       = docker_container.mysql.name
}