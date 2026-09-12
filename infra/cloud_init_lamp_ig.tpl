#cloud-config

datasource:
  Ec2:
    strict_id: false

ssh_pwauth: false

users:
- name: localadmin
  groups: [sudo]
  shell: /bin/bash
  sudo: ['ALL=(ALL) NOPASSWD:ALL']
  ssh-authorized-keys:
    - ${ssh_public_key}

runcmd:
  - |
    cat > /var/www/html/index.html <<EOF
    <!DOCTYPE html>
    <html>
    <head><title>LAMP</title></head>
    <body>
      <h1>Hello!</h1>
      <p>IP: $(hostname -I)</p>
      <p><img src="${picture_url}" alt="Picture" width="400"/></p>
    </body>
    </html>
    EOF
  - systemctl enable --now apache2