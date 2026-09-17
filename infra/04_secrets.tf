# ./terraform/04_secrets.tf

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

data "yandex_iam_service_account" "provider_sa" {
  service_account_id = jsondecode(file(pathexpand(var.service_account_key_file))).service_account_id
}

resource "yandex_kms_symmetric_key" "bucket_key" {
  name              = "bucket-encryption-key-${var.flow}"
  description       = "Симметричный KMS-ключ для шифрования бакета ${var.bucket_name}"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}

resource "yandex_resourcemanager_folder_iam_member" "kms_encrypter_decrypter" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${data.yandex_iam_service_account.provider_sa.id}"
}