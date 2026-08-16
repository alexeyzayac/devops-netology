# terraform/07_inventory.tf

resource "local_file" "ansible_inventory" {
  content         = templatefile("${path.module}/templates/inventory.yml.tpl", {
    kube_ip       = yandex_compute_instance.vm_kube.network_interface[0].nat_ip_address
    vm_user       = var.vm_user
    ssh_key_path  = abspath("${path.module}/../secrets/cloud-${var.flow}")
  })
  filename        = "${path.module}/../ansible/inventory.yml"
}