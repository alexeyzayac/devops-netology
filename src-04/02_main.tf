### src-04/02_main.tf

module "vpc_dev" {
  source         = "./vpc"
  env_name       = var.vpc_name
  subnets = [
    { zone = var.default_zone, cidr = var.default_cidr[0] }
  ]
}

module "vpc_prod" {
  source   = "./vpc"
  env_name = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.1.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.1.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.1.3.0/24" },
  ]
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
  public_ip      = true
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
  public_ip      = true
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

