# terraform/07_inventory.tf

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.yml.tpl", {
    sentry_ip = yandex_compute_instance.vm_sentry.network_interface[0].nat_ip_address
    ssh_key_path = abspath("${path.module}/../secrets/cloud-${var.flow}")
  })
  filename = "${path.module}/../ansible/inventory.yml"
}