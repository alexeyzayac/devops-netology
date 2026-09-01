# Домашнее задание к занятию 7 "`Helm`" - `Заяц Алексей`

### Цель задания

В тестовой среде Kubernetes необходимо установить и обновить приложения с помощью Helm.

------

### Чеклист готовности к домашнему заданию

1. Установленное k8s-решение (например, MicroK8S).
2. Установленный локальный kubectl.
3. Редактор YAML-файлов с подключенным Git-репозиторием.
4. Установленный локальный Helm
------

### Дополнительные материалы, которые пригодятся для выполнения задания
1. [Инструкция](https://helm.sh/docs/intro/install/) по установке Helm. [Helm completion](https://helm.sh/docs/helm/helm_completion/).

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
```

![screenshot_1](./img/screenshot_1.png)

------

### Задание 1. 

1. Необходимо упаковать приложение в чарт для деплоя в разные окружения. 
2. Каждый компонент приложения деплоится отдельным deployment’ом или statefulset’ом.
3. В переменных чарта измените образ приложения для изменения версии.

### Решение:

```bash
helm create netology-chart
helm template . --debug
```

**[Созданный чарт](netology-chart/)**

![screenshot_2](./img/screenshot_2.png)

------

### Задание 2. 

1. Подготовив чарт, необходимо его проверить. Запуститe несколько копий приложения.
2. Одну версию в namespace=app1, вторую версию в том же неймспейсе, третью версию в namespace=app2.
3. Продемонстрируйте результат.

### Решение:

```bash
kubectl create namespace app1
kubectl create namespace app2

#Релиз 1
helm install app1-v1 ./netology-chart \
  --namespace app1 \
  --set nginx.image.tag=1.31.4 \
  --set replicas=1

#Релиз 2
helm install app1-v2 ./netology-chart \
  --namespace app1 \
  --set nginx.image.tag=1.30.4 \
  --set replicas=1

#Релиз 3
helm install app2-v1 ./netology-chart \
  --namespace app2 \
  --set nginx.image.tag=1.31.4 \
  --set replicas=1 \
  --set service.port=8080

```

![screenshot_3](./img/screenshot_3.png)
