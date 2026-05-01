variable "ip_address" {
  description = "ip-адрес"
  type        = string

  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.ip_address))
    error_message = "Ошибка."
  }
}

variable "ip_list" {
  description = "список ip-адресов"
  type        = list(string)

  validation {
    condition = alltrue([
      for ip in var.ip_list : can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", ip))
    ])
    error_message = "Ошибка"
  }
}