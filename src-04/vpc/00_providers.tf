### src-04/vpc/00_providers.tf

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.201.0"
    }
  }
}