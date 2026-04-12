### infra/docker/00_providers.tf

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.1.0"
    }
  }
  required_version = ">= 1.0"
}

data "terraform_remote_state" "infra" {
  backend   = "local"
  config    = {
    path    = "../terraform.tfstate"
  }
}

provider "docker" {
  host      = "ssh://${data.terraform_remote_state.infra.outputs.vm_user}@${data.terraform_remote_state.infra.outputs.vm_docker_public_ip}:22"
  ssh_opts  = [
    "-o", "StrictHostKeyChecking=no",
    "-o", "UserKnownHostsFile=/dev/null",
    "-i", "../../secrets/cloud-${data.terraform_remote_state.infra.outputs.flow}"
  ]
}
