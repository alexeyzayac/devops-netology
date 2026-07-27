### terraform/05_compute_image.tf

data "yandex_compute_image" "toolbox" {
  family = "ubuntu-2404-lts-oslogin"
}