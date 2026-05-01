### src-04/vpc/01_variables.tf

variable "env_name" {
  description = "Название сети и подсети"
  type        = string
}

variable "subnets" {
  description = "Список подсетей с зонами и CIDR-блоками"
  type = list(object({
    zone = string
    cidr = string
  }))
}
