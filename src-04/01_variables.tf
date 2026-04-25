### src-04/01_variables.tf

variable "token" {
  description = "OAuth-токен Яндекс Облака"
  type        = string
}

variable "cloud_id" {
  description = "Идентификатор облака Яндекс Облака"
  type        = string
  default     = "b1gkcijp41up8neg1us5"
}

variable "folder_id" {
  description = "Идентификатор каталога Яндекс Облака"
  type        = string
  default     = "b1g6420ee2tu1c99o714"
}

variable "default_zone" {
  description = "Зона доступности по умолчанию"
  type        = string
  default     = "ru-central1-a"
}

variable "default_cidr" {
  description = "Список CIDR-блоков для подсети"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vpc_name" {
  description = "Название VPC сети и подсети"
  type        = string
  default     = "develop"
}

variable "vms_ssh_root_key" {
  description = "Публичный SSH-ключ для доступа к виртуальным машинам"
  type        = string
}
