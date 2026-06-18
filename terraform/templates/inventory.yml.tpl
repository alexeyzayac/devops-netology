---

all:
  children:
    teamcity_servers:
      hosts:
        teamcity-server:
          ansible_host: ${server_ip}
          ansible_user: localadmin
          ansible_ssh_private_key_file: ${ssh_key_path}
    teamcity_agents:
      hosts:
        teamcity-agent:
          ansible_host: ${agent_ip}
          ansible_user: localadmin
          ansible_ssh_private_key_file: ${ssh_key_path}
    nexus:
      hosts:
        nexus:
          ansible_host: ${nexus_ip}
          ansible_user: localadmin
          ansible_ssh_private_key_file: ${ssh_key_path}

...