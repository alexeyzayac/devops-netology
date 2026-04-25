### src-04/vpc/01_variables.tf

variable "env_name" {
  description = "Название сети и подсети"
  type        = string
}

variable "zone" {
  description = "Зона доступности для подсети"
  type        = string
}

variable "v4_cidr_blocks" {
  description = "IPv4 CIDR-блок для подсети"
  type        = string
}