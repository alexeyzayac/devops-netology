### infra/01_variables.tf

variable "flow" {
  description = "Идентификатор проекта для именования ресурсов"
  type        = string
  default     = "zayac-04-2026"
}

variable "yandex_service_account_key_path" {
  description = "Путь к JSON-файлу с ключом сервисного аккаунта Yandex Cloud"
  type        = string
  default     = "~/.yandex/authorized_key.json"
}

variable "yandex_cloud_id" {
  description = "Идентификатор облака Yandex Cloud"
  type        = string
  default     = "b1guknff8nknnqp3g18s"
}

variable "yandex_folder_id" {
  description = "Идентификатор каталога Yandex Cloud"
  type        = string
  default     = "b1gb00710li9ve0ujpkm"
}

variable "vm_user" {
  description = "Имя пользователя для SSH-подключения к ВМ"
  type        = string
  default     = "localadmin"
}