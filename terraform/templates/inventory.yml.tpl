---

all:
  children:
    sentry_servers:
      hosts:
        sentry-server:
          ansible_host: ${sentry_ip}
          ansible_user: localadmin
          ansible_ssh_private_key_file: ${ssh_key_path}

...