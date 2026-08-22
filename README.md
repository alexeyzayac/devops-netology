# Домашнее задание к занятию 2 "`Базовые объекты K8S`" - `Заяц Алексей`

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Pod с приложением и подключиться к нему со своего локального компьютера.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным Git-репозиторием.

### Решение:

#### Уситановка kubectl

```bash
curl -LO "https://dl.k8s.io/release/v1.35.0/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version
```

#### Установка Minikube на локальный АРМ

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version

#Для поднятия класстера
minikube start --driver=virtualbox --cpus=4 --memory=8gb --disk-size=20gb -p zayac

#Для удаления
minikube delete -p zayac
```

![img](img/screenshot_1.png)

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания
1. Описание Pod и примеры манифестов.
2. Описание Service.

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания

1. [Инструкция](https://microk8s.io/docs/getting-started) по установке MicroK8S.
2. [Инструкция](https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/#bash) по установке автодополнения **kubectl**.
3. [Шпаргалка](https://kubernetes.io/ru/docs/reference/kubectl/cheatsheet/) по **kubectl**.

------

### Задание 1. Создать Pod с именем hello-world

1. Создать манифест (yaml-конфигурацию) Pod.
2. Использовать image - gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Подключиться локально к Pod с помощью kubectl port-forward и вывести значение (curl или в браузере).

### Решение:

**[Манифест пода](kube/pod-hello-world.yaml)**

```bash
kubectl apply -f pod-hello-world.yaml
kubectl port-forward pod/hello-world 8088:8080
```

![img](img/screenshot_2.png)

------

### Задание 2. Создать Service и подключить его к Pod
1. Создать Pod с именем netology-web.
2. Использовать image — gcr.io/kubernetes-e2e-test-images/echoserver:2.2.
3. Создать Service с именем netology-svc и подключить к netology-web.
4. Подключиться локально к Service с помощью kubectl port-forward и вывести значение (curl или в браузере).

### Решение:

**[Манифест пода](kube/pod-netology-web.yaml)**

**[Манифест сервиса](kube/service-netology-svc.yml)**

```bash
kubectl apply -f pod-netology-web.yaml
kubectl apply -f service-netology-svc.yml
kubectl port-forward service/netology-svc 8088:8088
```

![img](img/screenshot_3.png)
