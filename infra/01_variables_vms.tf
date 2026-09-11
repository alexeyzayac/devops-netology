# ./terraform/01_variables_vms.tf

variable "nat_resources" {
  description = "Параметры ресурсов NAT-инстанса"
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    image_id      = string
    hdd_size      = number
    hdd_type      = string
  })
  default = {
    cores         = 2
    memory        = 4
    core_fraction = 20
    image_id      = "fd80mrhj8fl2oe87o4e1" # Ubuntu 18.04 с преднастроенным NAT
    hdd_size      = 20
    hdd_type      = "network-hdd"
  }
  nullable = false
}

variable "public_vm_resources" {
  description = "Параметры ресурсов публичной ВМ"
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    image_id      = string
    hdd_size      = number
    hdd_type      = string
  })
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
    image_id      = "fd8vmcue7aajpmeo39kk" # Ubuntu 20.04 LTS
    hdd_size      = 20
    hdd_type      = "network-hdd"
  }
  nullable = false
}

variable "private_vm_resources" {
  description = "Параметры ресурсов приватной ВМ"
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
    image_id      = string
    hdd_size      = number
    hdd_type      = string
  })
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
    image_id      = "fd8vmcue7aajpmeo39kk" # Ubuntu 20.04 LTS
    hdd_size      = 20
    hdd_type      = "network-hdd"
  }
  nullable = false
}
