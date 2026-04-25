terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.12.0"
}

provider "yandex" {
  cloud_id                 = "b1guknff8nknnqp3g18s"
  folder_id                = "b1gb00710li9ve0ujpkm"
  service_account_key_file = file("~/.yandex/authorized_key.json")
  zone                     = "ru-central1-a"
}
