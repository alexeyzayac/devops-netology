#cloud-config

datasource:
  Ec2:
    strict_id: false

ssh_pwauth: false

users:
  - name: ${vm_user}
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ${public_key}

package_update: true
package_upgrade: true

packages:
  - python3
  - curl
  - snapd

runcmd:
  - apt-get update
