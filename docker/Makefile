up:
	docker run -d --name ubuntu_ansible --privileged --cgroupns=host --stop-signal=SIGRTMIN+3 -v /sys/fs/cgroup:/sys/fs/cgroup:rw ubuntu_ansible:latest
	docker run -d --name oraclelinux_ansible --privileged --cgroupns=host --stop-signal=SIGRTMIN+3 -v /sys/fs/cgroup:/sys/fs/cgroup:rw oraclelinux_ansible:latest

down:
	docker stop ubuntu_ansible oraclelinux_ansible || true
	docker rm ubuntu_ansible oraclelinux_ansible || true