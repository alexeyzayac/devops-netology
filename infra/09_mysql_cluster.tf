# ./infra/09_mysql_cluster.tf

resource "yandex_mdb_mysql_cluster" "mysql_cluster" {
  description = "Отказоустойчивый кластер MySQL для потока ${var.flow}"
  name        = "mysql-cluster-${var.flow}"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.main.id
  version     = "8.0"

  resources {
    resource_preset_id = "b2.medium"
    disk_type_id       = "network-hdd"
    disk_size          = 20
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  backup_window_start {
    hours   = 23
    minutes = 59
  }

  # Защита кластера от непреднамеренного удаления
  # deletion_protection = true

  security_group_ids = [yandex_vpc_security_group.mysql_sg.id]

  host {
    zone      = var.zone
    subnet_id = yandex_vpc_subnet.private.id
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.private_b.id
  }

  host {
    zone      = "ru-central1-d"
    subnet_id = yandex_vpc_subnet.private_d.id
  }

  depends_on = [
    yandex_vpc_subnet.private,
    yandex_vpc_subnet.private_b,
    yandex_vpc_subnet.private_d,
  ]
}

resource "yandex_mdb_mysql_database" "netology_db" {
  cluster_id = yandex_mdb_mysql_cluster.mysql_cluster.id
  name       = "netology_db"
}

resource "yandex_mdb_mysql_user" "netology_user" {
  cluster_id = yandex_mdb_mysql_cluster.mysql_cluster.id
  name       = var.mysql_user_name
  password   = var.mysql_user_password

  permission {
    database_name = yandex_mdb_mysql_database.netology_db.name
    roles         = ["ALL"]
  }
}