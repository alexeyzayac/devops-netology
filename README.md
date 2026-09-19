# Домашнее задание к занятию 4 "`Кластеры. Ресурсы под управлением облачных провайдеров`" - `Заяц Алексей`

### Цели задания 

1. Организация кластера Kubernetes и кластера баз данных MySQL в отказоустойчивой архитектуре.
2. Размещение в private подсетях кластера БД, а в public — кластера Kubernetes.

## Задание 1. Yandex Cloud

1. Настроить с помощью Terraform кластер баз данных MySQL.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно подсеть private в разных зонах, чтобы обеспечить отказоустойчивость. 
 - Разместить ноды кластера MySQL в разных подсетях.
 - Необходимо предусмотреть репликацию с произвольным временем технического обслуживания.
 - Использовать окружение Prestable, платформу Intel Broadwell с производительностью 50% CPU и размером диска 20 Гб.
 - Задать время начала резервного копирования — 23:59.
 - Включить защиту кластера от непреднамеренного удаления.
 - Создать БД с именем `netology_db`, логином и паролем.

2. Настроить с помощью Terraform кластер Kubernetes.

 - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно две подсети public в разных зонах, чтобы обеспечить отказоустойчивость.
 - Создать отдельный сервис-аккаунт с необходимыми правами. 
 - Создать региональный мастер Kubernetes с размещением нод в трёх разных подсетях.
 - Добавить возможность шифрования ключом из KMS, созданным в предыдущем домашнем задании.
 - Создать группу узлов, состояющую из трёх машин с автомасштабированием до шести.
 - Подключиться к кластеру с помощью `kubectl`.
 - *Запустить микросервис phpmyadmin и подключиться к ранее созданной БД.
 - *Создать сервис-типы Load Balancer и подключиться к phpmyadmin. Предоставить скриншот с публичным адресом и подключением к БД.

Полезные документы:

- [MySQL cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster).
- [Создание кластера Kubernetes](https://cloud.yandex.ru/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create)
- [K8S Cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster).
- [K8S node group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group).

## Результат:

**Код для поднятия инфраструктуры находиться в [директории](./infra/)**

Были обновлены конфигурации:
* 01_variables.tf
* 02_network.tf
* 03_security_group.tf
* 04_secrets.tf
* 99_outputs.tf
* terraform.tfvars

Были созданы конфигурации: 
* 09_mysql_cluster.tf
* 10_kubernetes.tf

### Созданные ресурсы:

![screenshot_1.png](./img/screenshot_1.png)

### Созданные ноды кластера в разных подсетях:

![screenshot_2.png](./img/screenshot_2.png)

### Проверка базы данных:

```bash
mysql --host=rc1a-gk7mr6fulhiv2tr8.mdb.yandexcloud.net \
      --port=3306 \
      --ssl-mode=REQUIRED \
      --user=netology_user \
      --password=Qwerty123
```

```bash
SHOW DATABASES;
USE netology_db;
CREATE TABLE hello (x INT);
INSERT INTO hello (x) VALUES (10);
SELECT * FROM hello;
```

![screenshot_3.png](./img/screenshot_3.png)

### Созданный кластер:

![screenshot_4.png](./img/screenshot_4.png)

![screenshot_5.png](./img/screenshot_5.png)

### Узлы кластер:

![screenshot_6.png](./img/screenshot_6.png)

![screenshot_7.png](./img/screenshot_7.png)

### Проверка `kubectl`

![screenshot_8.png](./img/screenshot_8.png)

### Карта итогов с 1 по 4 задание:

![screenshot_9.png](./img/screenshot_9.png)