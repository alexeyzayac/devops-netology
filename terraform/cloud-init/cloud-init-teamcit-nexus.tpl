#cloud-config

datasource:
  Ec2:
    strict_id: false

ssh_pwauth: false

users:
  - name: localadmin
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ${public_key}

package_update: true
package_upgrade: true

packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - software-properties-common
  - coreutils
  - ncurses-bin
  - locales
  - python3

runcmd:
  - locale-gen en_US.UTF-8
  - update-locale LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
  - timedatectl set-timezone Europe/Moscow
  - echo 'force_color_prompt=yes' >> /home/localadmin/.bashrc
  - echo 'force_color_prompt=yes' >> /root/.bashrc