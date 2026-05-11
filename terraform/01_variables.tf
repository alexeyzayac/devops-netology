# terraform/01_variables.tf

variable "flow" {
  type        = string
  default     = "zayac-05-2026"
  description = "Идентификатор потока или версии для отслеживания изменений в конфигурации"
}

variable "yandex_cloud_id" {
  type        = string
  default     = "b1guknff8nknnqp3g18s"
  description = "Уникальный идентификатор облака в Yandex Cloud"
}

variable "yandex_folder_id" {
  type        = string
  default     = "b1gb00710li9ve0ujpkm"
  description = "Уникальный идентификатор каталога внутри облака Yandex Cloud"
}