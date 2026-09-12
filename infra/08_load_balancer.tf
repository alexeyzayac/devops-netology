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
      name                = "http-healthcheck"
      interval            = 10
      timeout             = 5
      unhealthy_threshold = 3
      healthy_threshold   = 2

      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
