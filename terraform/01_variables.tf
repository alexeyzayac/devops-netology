# terraform/01_variables.tf

variable "flow" {
  type        = string
  default     = "zayac-05-2026"
  description = "Идентификатор потока или версии для отслеживания изменений в конфигурации"
}

variable "yandex_cloud_id" {
  type        = string
  default     = "b1g6agb0n814nehr1fre"
  description = "Уникальный идентификатор облака в Yandex Cloud"
}

variable "yandex_folder_id" {
  type        = string
  default     = "b1gdi9ob4is7cn8v4mu7"
  description = "Уникальный идентификатор каталога внутри облака Yandex Cloud"
}