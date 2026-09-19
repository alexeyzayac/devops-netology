# ./infra/99_outputs.tf

output "public_vm_public_ip" {
  description = "Публичный IP-адрес публичной ВМ"
  value       = yandex_compute_instance.public_vm.network_interface.0.nat_ip_address
}

output "private_vm_internal_ip" {
  description = "Внутренний IP-адрес приватной ВМ"
  value       = yandex_compute_instance.private_vm.network_interface.0.ip_address
}

output "nat_instance_public_ip" {
  description = "Публичный IP-адрес NAT-инстанса"
  value       = yandex_compute_instance.nat_instance.network_interface.0.nat_ip_address
}

output "nat_instance_internal_ip" {
  description = "Внутренний IP-адрес NAT-инстанса"
  value       = yandex_compute_instance.nat_instance.network_interface.0.ip_address
}

output "bucket_picture_url" {
  description = "Публичный URL картинки в бакете"
  value       = "https://${yandex_storage_bucket.picture_bucket.bucket}.storage.yandexcloud.net/picture.jpg"
}

output "nlb_public_ip" {
  description = "Публичный IP сетевого балансировщика"
  value       = tolist(tolist(yandex_lb_network_load_balancer.nlb.listener)[0].external_address_spec)[0].address
}

output "k8s_cluster_id" {
  description = "ID кластера Kubernetes"
  value       = yandex_kubernetes_cluster.k8s_cluster.id
}

output "k8s_cluster_name" {
  description = "Имя кластера Kubernetes"
  value       = yandex_kubernetes_cluster.k8s_cluster.name
}