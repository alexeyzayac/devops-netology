### src-04/02_main.tf

# Локальный модуль vpc (сеть + подсеть)
module "vpc_dev" {
  source         = "./vpc"
  env_name       = var.vpc_name
  zone           = var.default_zone
  v4_cidr_blocks = var.default_cidr[0]
}

# ВМ для проекта marketing
module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = "web-marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = false
  labels = {
    owner   = "a.zayats"
    project = "marketing"
  }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

# ВМ для проекта analytics
module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = "web-analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = false
  labels = {
    owner   = "a.zayats"
    project = "analytics"
  }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

# Подготовка cloud-init из шаблона
data "template_file" "cloudinit" {
  template = file("./00_cloud-init.yml")
  vars = {
    ssh_key = var.vms_ssh_root_key
  }
}
