# terraform/08_inventory.tf

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.yml.tpl", {
    server_ip   = yandex_compute_instance.teamcity_server.network_interface[0].nat_ip_address
    agent_ip    = yandex_compute_instance.teamcity_agent.network_interface[0].nat_ip_address
    nexus_ip    = yandex_compute_instance.nexus.network_interface[0].nat_ip_address
    ssh_key_path = abspath("${path.module}/../secrets/cloud-${var.flow}")
  })
  filename = "${path.module}/../ansible/inventory.yml"
}