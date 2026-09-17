# ./terraform/08_load_balancer.tf

resource "yandex_lb_network_load_balancer" "nlb" {
  name = "nlb-${var.flow}"
  type = "external"

  listener {
    name = "nlb-listener-http"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp_ig.load_balancer.0.target_group_id

    healthcheck {
      name                = local.healthcheck.name
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
}
