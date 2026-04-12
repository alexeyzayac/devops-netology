### infra/00_providers.tf

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.197.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.8.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.8"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.2.1"
    }
  }
  required_version = "~>1.12.0"
}

provider "yandex" {
  cloud_id                 = var.yandex_cloud_id
  folder_id                = var.yandex_folder_id
  service_account_key_file = file(var.yandex_service_account_key_path)
}