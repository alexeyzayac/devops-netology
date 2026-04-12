### infra/04_secrets.tf

# SSH-ключ
resource "tls_private_key" "ssh" {
  algorithm = "ED25519"
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh.private_key_openssh
  filename        = "${path.module}/../secrets/cloud-${var.flow}"
  file_permission = "0600"
}

resource "local_file" "public_key" {
  content         = tls_private_key.ssh.public_key_openssh
  filename        = "${path.module}/../secrets/cloud-${var.flow}.pub"
  file_permission = "0644"
}

# Пароли MySQL
resource "random_password" "mysql_root_password" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "mysql_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "local_file" "mysql_root_password_output" {
  filename = "${path.module}/../secrets/mysql_root_password.txt"
  content  = random_password.mysql_root_password.result
}

resource "local_file" "mysql_password_output" {
  filename = "${path.module}/../secrets/mysql_password.txt"
  content  = random_password.mysql_password.result
}