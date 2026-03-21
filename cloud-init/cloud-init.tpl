#cloud-config

datasource:
  Ec2:
    strict_id: false

ssh_pwauth: no

users:
  - name: localadmin
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ${public_key}

runcmd:
  - apt update && apt -y full-upgrade