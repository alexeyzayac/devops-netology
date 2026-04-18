locals {
  web_vm_name = "${var.company}-${var.project}-${var.platform}-${var.role_web}"
  db_vm_name  = "${var.company}-${var.project}-${var.platform}-${var.role_db}"

  vm_metadata = merge(var.metadata_common, {
    "ssh-keys" = "ubuntu:${file(var.vms_ssh_public_root_key)}"
  })
}