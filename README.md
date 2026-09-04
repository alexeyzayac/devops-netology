# Домашнее задание к занятию 9 "`Установка Kubernetes`" - `Заяц Алексей`

### Цель задания

Установить кластер K8s.

### Чеклист готовности к домашнему заданию

1. Развёрнутые ВМ с ОС Ubuntu 20.04-lts.

**П.С: Использовалась ОС Ubuntu 22.04.5-lts.**

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция по установке kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/).
2. [Документация kubespray](https://kubespray.io/).

-----

### Задание 1. Установить кластер k8s с 1 master node

1. Подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды.
2. В качестве CRI — containerd.
3. Запуск etcd производить на мастере.
4. Способ установки выбрать самостоятельно.

### Решение:

**Машины подняты через [Vagrant](./vagrant/Vagrantfile) в VirtualBox:**

![screenshot_1.png](./img/screenshot_1.png)

**Для развертывания кластера были написаны [playbook](./vagrant/playbook/site.yml), после ручной настройки, итог:**

![screenshot_2.png](./img/screenshot_2.png)

**Итог после отработки, проверка на master-node:**

![screenshot_3.png](./img/screenshot_3.png)

-----

### Задание 2*. Установить HA кластер

1. Установить кластер в режиме HA.
2. Использовать нечётное количество Master-node.
3. Для cluster ip использовать keepalived или другой способ.

### Решение:

