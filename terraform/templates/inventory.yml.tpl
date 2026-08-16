---

all:
  children:
    kube_servers:
      hosts:
        kube-server:
          ansible_host: ${kube_ip}
          ansible_user: ${vm_user}
          ansible_ssh_private_key_file: ${ssh_key_path}

...