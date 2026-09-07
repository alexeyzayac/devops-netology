# Домашнее задание к занятию 10 "`Как работает сеть в K8s`" - `Заяц Алексей`

### Цель задания

Настроить сетевую политику доступа к подам.

### Чеклист готовности к домашнему заданию

1. Кластер K8s с установленным сетевым плагином Calico.

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Документация Calico](https://www.tigera.io/project-calico/).
2. [Network Policy](https://kubernetes.io/docs/concepts/services-networking/network-policies/).
3. [About Network Policy](https://docs.projectcalico.org/about/about-network-policy).

-----

### Задание 1. Создать сетевую политику или несколько политик для обеспечения доступа

1. Создать deployment'ы приложений frontend, backend и cache и соответсвующие сервисы.
2. В качестве образа использовать network-multitool.
3. Разместить поды в namespace App.
4. Создать политики, чтобы обеспечить доступ frontend -> backend -> cache. Другие виды подключений должны быть запрещены.
5. Продемонстрировать, что трафик разрешён и запрещён.

### Решение:

Манифест для [Namespace](./kube/app.yaml)

Манифест для [Deployment-frontend](./kube/frontend.yaml)

Манифест для [Deployment-backend](./kube/backend.yaml)

Манифест для [Deployment-cache](./kube/cache.yaml)

Манифест для [NetworkPolicy](./kube/network-policy.yaml)

**Итог:**

![screenshot_1.png](./img/screenshot_1.png)