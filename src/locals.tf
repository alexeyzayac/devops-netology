locals {
  web_vm_name = "${var.company}-${var.project}-${var.platform}-${var.role_web}"
  db_vm_name  = "${var.company}-${var.project}-${var.platform}-${var.role_db}"
}