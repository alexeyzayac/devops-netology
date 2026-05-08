#!/usr/bin/env bash

set -e

### Удалять в случае ошибки работы контейнера
cleanup() {
    docker rm -f centos7 fedora ubuntu 2>/dev/null || true
    docker rmi centos-ansible:latest fedora-ansible:latest ubuntu-ansible:latest 2>/dev/null || true
    rm -f "$TEMP_VAULT_FILE"
}

trap cleanup EXIT

### Ввод пароля для ansible-vault
read -s -p "Введите пароль Ansible Vault: " VAULT_PASS
if [ -z "$VAULT_PASS" ]; then
    echo -e "\nПароль не должен быть пустым" >&2
    exit 1
fi

echo
echo "Пароль принят"

### Создание временного файла с паролем
TEMP_VAULT_FILE=$(mktemp)
echo "$VAULT_PASS" > "$TEMP_VAULT_FILE"

### Сбор контейнеров
docker build -f docker/Dockerfile_centos -t centos-ansible:latest docker
docker build -f docker/Dockerfile_fedora -t fedora-ansible:latest docker
docker build -f docker/Dockerfile_ubuntu -t ubuntu-ansible:latest docker

### Старт контейнеров
docker run -d --name centos7 centos-ansible:latest
docker run -d --name fedora fedora-ansible:latest
docker run -d --name ubuntu ubuntu-ansible:latest

### Запуск Playbook
cd playbook || exit 1
ansible-playbook -i inventory/prod.yml site.yml --vault-password-file "$TEMP_VAULT_FILE"

### Принудительная остановка с удалением
docker rm -f centos7 fedora ubuntu

### Удаление Image
docker rmi centos-ansible:latest fedora-ansible:latest ubuntu-ansible:latest

### Удаление временного файла с паролем
rm -f "$TEMP_VAULT_FILE"