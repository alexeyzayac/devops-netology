# ./terraform/01_locals.tf

locals {
  healthcheck = {
    name                = "http-healthcheck"
    interval            = 10
    timeout             = 5
    unhealthy_threshold = 3
    healthy_threshold   = 2
    port                = 80
    path                = "/"
  }
}