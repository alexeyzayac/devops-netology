# ./infra/01_variables.tf

variable "flow" {
  description = "Переменная для идентификации версии"
  type        = string
  nullable    = false
}

variable "cloud_id" {
  description = "Идентификатор облака в Yandex Cloud"
  type        = string
  nullable    = false
}

variable "folder_id" {
  description = "Идентификатор каталога в облаке Yandex Cloud"
  type        = string
  nullable    = false
}

variable "service_account_key_file" {
  description = "Путь к JSON-ключу сервисного аккаунта Yandex Cloud"
  type        = string
  nullable    = false
}

variable "zone" {
  description = "Зона доступности Yandex Cloud"
  type        = string
  default     = "ru-central1-a"
  nullable    = false
}

variable "image_path" {
  description = "Путь к файлу с картинкой для загрузки в бакет"
  type        = string
  default     = "../bucket_img/image.jpg"
  nullable    = false
}

variable "mysql_user_name" {
  description = "Имя пользователя MySQL"
  type        = string
  nullable    = false
}

variable "mysql_user_password" {
  description = "Пароль пользователя MySQL"
  type        = string
  sensitive   = true
  nullable    = false
}