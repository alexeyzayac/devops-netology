###cloud vars
variable "cloud_id" {
  type    = string
  default = "b1guknff8nknnqp3g18s"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type    = string
  default = "b1gb00710li9ve0ujpkm"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###ssh vars
variable "vms_ssh_public_root_key" {
  type        = string
  default     = "../secrets/my_ed25519_key.pub"
  description = "ssh-keygen -t ed25519 -f ../secrets"
}

### naming parts (для local)
variable "company" {
  type    = string
  default = "netology"
}

variable "project" {
  type    = string
  default = "develop"
}

variable "platform" {
  type    = string
  default = "platform"
}

variable "role_web" {
  type    = string
  default = "web"
}

variable "role_db" {
  type    = string
  default = "db"
}

### map-переменная
variable "vms_resources" {
  description = "Resources for each VM"
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      hdd_size      = 10
      hdd_type      = "network-hdd"
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 10
      hdd_type      = "network-hdd"
    }
  }
}

### map-переменная для metadata (общая для всех ВМ)
variable "metadata_common" {
  description = "Common metadata for all VMs (without ssh-keys)"
  type        = map(string)
  default = {
    serial-port-enable = "1"
  }
}