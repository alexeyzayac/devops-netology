###cloud vars
variable "token" {
  type        = string
}

variable "cloud_id" {
  type        = string
  default     = "b1guknff8nknnqp3g18s"
}

variable "folder_id" {
  type        = string
  default     = "b1gb00710li9ve0ujpkm"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vpc_name" {
  type        = string
  default     = "develop"
}

variable "vms_ssh_root_key" {
  type        = string
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
}



