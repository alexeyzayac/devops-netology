# ./infra/10_kubernetes.tf

resource "yandex_kubernetes_cluster" "k8s_cluster" {
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_sa_roles["k8s.clusters.agent"],
    yandex_resourcemanager_folder_iam_member.k8s_sa_roles["kms.keys.encrypterDecrypter"],
    yandex_resourcemanager_folder_iam_member.k8s_sa_roles["container-registry.images.puller"],
    yandex_resourcemanager_folder_iam_member.k8s_sa_roles["vpc.publicAdmin"],
  ]
  description = "Региональный кластер Kubernetes для ${var.flow}"
  name        = "k8s-cluster-${var.flow}"
  network_id  = yandex_vpc_network.main.id

  master {
    version = "1.34"

    regional {
      region = "ru-central1"

      location {
        zone      = yandex_vpc_subnet.public.zone
        subnet_id = yandex_vpc_subnet.public.id
      }
      location {
        zone      = yandex_vpc_subnet.public_b.zone
        subnet_id = yandex_vpc_subnet.public_b.id
      }
      location {
        zone      = yandex_vpc_subnet.public_d.zone
        subnet_id = yandex_vpc_subnet.public_d.id
      }
    }

    public_ip = true

    security_group_ids = [yandex_vpc_security_group.k8s_sg.id]

    maintenance_policy {
      auto_upgrade = true
      maintenance_window {
        day        = "saturday"
        start_time = "12:00"
        duration   = "3h"
      }
    }
  }

  kms_provider {
    key_id = yandex_kms_symmetric_key.bucket_key.id
  }

  service_account_id      = yandex_iam_service_account.k8s_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_sa.id

  release_channel         = "REGULAR"
  network_policy_provider = "CALICO"

  cluster_ipv4_range = "10.200.0.0/16"
  service_ipv4_range = "10.210.0.0/16"
}

resource "yandex_kubernetes_node_group" "k8s_nodes" {
  depends_on = [
    yandex_kubernetes_cluster.k8s_cluster,
  ]
  cluster_id = yandex_kubernetes_cluster.k8s_cluster.id
  name       = "k8s-nodes-${var.flow}"
  version    = "1.34"

  scale_policy {
    auto_scale {
      min     = 3
      max     = 6
      initial = 3
    }
  }

  allocation_policy {
    location {
      zone = yandex_vpc_subnet.public.zone
    }
  }

  instance_template {
    platform_id = "standard-v3"

    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.public.id]
      security_group_ids = [yandex_vpc_security_group.k8s_sg.id]
    }

    resources {
      cores  = 2
      memory = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    container_runtime {
      type = "containerd"
    }
  }
}