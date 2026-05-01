### src-04/00_providers.tf

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.201.0"
    }
    template = { 
      source = "hashicorp/template"
      version = "~> 2.2" 
    }
  }
  required_version = "~>1.12.0"

  backend "s3" {
    bucket  = "tfstate-develop-zayac"
    key     = "develop/terraform.tfstate"
    region  = "ru-central1"
    
    use_lockfile = true
    
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

