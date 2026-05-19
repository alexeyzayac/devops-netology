resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.web
    databases  = yandex_compute_instance.db
    storage    = [yandex_compute_instance.storage]
  })

  filename = "${abspath(path.module)}/inventory.ini"
  depends_on = [
    yandex_compute_instance.web,
    yandex_compute_instance.db,
    yandex_compute_instance.storage
  ]
}