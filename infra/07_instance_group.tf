# ./terraform/07_instance_group.tf

resource "yandex_iam_service_account" "ig_sa" {
  name = "ig-service-account-${var.flow}"
}

resource "yandex_resourcemanager_folder_iam_binding" "ig_sa_editor" {
  folder_id = var.folder_id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.ig_sa.id}",
  ]
}

resource "yandex_compute_instance_group" "lamp_ig" {
  depends_on = [
    yandex_storage_object.picture,
    yandex_vpc_subnet.public,
    yandex_resourcemanager_folder_iam_binding.ig_sa_editor,
  ]

  name               = "lamp-ig-${var.flow}"
  folder_id          = var.folder_id
  service_account_id = yandex_iam_service_account.ig_sa.id

  instance_template {
    name        = "lamp-vm-{instance.index}"
    platform_id = "standard-v3"

    resources {
      cores         = var.ig_resources.cores
      memory        = var.ig_resources.memory
      core_fraction = var.ig_resources.core_fraction
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.ig_resources.image_id
        type     = var.ig_resources.hdd_type
        size     = var.ig_resources.hdd_size
      }
    }

    network_interface {
      network_id         = yandex_vpc_network.main.id
      subnet_ids         = [yandex_vpc_subnet.public.id]
      nat                = false
      security_group_ids = [yandex_vpc_security_group.ig_sg.id]
    }

    metadata = {
      hostname = "lamp-vm-{instance.index}"
      user-data = templatefile("${path.module}/cloud_init_lamp_ig.tpl", {
        ssh_public_key = trimspace(tls_private_key.ssh.public_key_openssh)
        picture_url    = "https://${yandex_storage_bucket.picture_bucket.bucket}.storage.yandexcloud.net/picture.jpg"
      })
    }
  }

  scale_policy {
    fixed_scale {
      size = var.ig_resources.fixed_scale
    }
  }

  allocation_policy {
    zones = [var.zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name = "lamp-tg-${var.flow}"
  }

  health_check {
    interval            = local.healthcheck.interval
    timeout             = local.healthcheck.timeout
    unhealthy_threshold = local.healthcheck.unhealthy_threshold
    healthy_threshold   = local.healthcheck.healthy_threshold

    http_options {
      port = local.healthcheck.port
      path = local.healthcheck.path
    }
  }
}