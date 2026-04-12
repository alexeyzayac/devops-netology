resource "docker_image" "mysql" {
  name         = "mysql:8"
  keep_locally = false
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "tf-mysql-${data.terraform_remote_state.infra.outputs.flow}"

  ports {
    internal = 3306
    external = 3306
    ip       = "127.0.0.1"
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${data.terraform_remote_state.infra.outputs.mysql_root_password}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${data.terraform_remote_state.infra.outputs.mysql_password}",
    "MYSQL_ROOT_HOST=%"
  ]
}