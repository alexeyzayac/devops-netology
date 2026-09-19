# ./infra/04_secrets.tf

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
  description       = "Симметричный KMS-ключ для шифрования бакета ${var.flow}-bucket"
  name              = "bucket-encryption-key-${var.flow}"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}

resource "yandex_resourcemanager_folder_iam_member" "kms_encrypter_decrypter" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${data.yandex_iam_service_account.provider_sa.id}"
}

resource "yandex_iam_service_account" "k8s_sa" {
  description = "Сервис-аккаунт для Managed Kubernetes"
  name        = "k8s-sa-${var.flow}"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_sa_roles" {
  for_each = toset([
    "k8s.clusters.agent",
    "kms.keys.encrypterDecrypter",
    "container-registry.images.puller",
    "vpc.publicAdmin",
  ])

  folder_id = var.folder_id
  role      = each.value
  member    = "serviceAccount:${yandex_iam_service_account.k8s_sa.id}"
}
