# 05_compute_image.tf
locals {
  image_id = "fd8stsue5rim479kphah"
}

# либо data для справки, но это необязательно
data "yandex_compute_image" "toolbox" {
  image_id = local.image_id
}