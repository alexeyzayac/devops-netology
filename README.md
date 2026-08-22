# Домашнее задание к занятию 3 "`Запуск приложений в K8S`" - `Заяц Алексей`

### Цель задания

В тестовой среде для работы с Kubernetes, установленной в предыдущем ДЗ, необходимо развернуть Deployment с приложением, состоящим из нескольких контейнеров, и масштабировать его.

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
```

![img](img/screenshot_1.png)

------

### Инструменты и дополнительные материалы, которые пригодятся для выполнения задания
1. [Описание](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) Deployment и примеры манифестов.
2. [Описание](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) Init-контейнеров.
3. [Описание](https://github.com/wbitt/Network-MultiTool) Multitool.

------

### Задание 1. Создать Deployment и обеспечить доступ к репликам приложения из другого Pod
1. Создать Deployment приложения, состоящего из двух контейнеров — nginx и multitool. Решить возникшую ошибку.
2. После запуска увеличить количество реплик работающего приложения до 2.
3. Продемонстрировать количество подов до и после масштабирования.
4. Создать Service, который обеспечит доступ до реплик приложений из п.1.
5. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложений из п.1.

### Решение:

**[Манифест для деплоймент и сервис](kube/deployment-zadanie-1.yaml)**

#### Демонстрация масштабирования

![img](img/screenshot_2.png)

**[Манифест для пода](kube/pod-zadanie1.yaml)**

![img](img/screenshot_3.png)

------

### Задание 2. Создать Deployment и обеспечить старт основного контейнера при выполнении условий
1. Создать Deployment приложения nginx и обеспечить старт контейнера только после того, как будет запущен сервис этого приложения.
2. Убедиться, что nginx не стартует. В качестве Init-контейнера взять busybox.
3. Создать и запустить Service. Убедиться, что Init запустился.
4. Продемонстрировать состояние пода до и после запуска сервиса.

### Решение:

**[Манифест для деплоймент](kube/deployment-zadanie-2.yaml)**

**[Манифест для сервис](kube/service-zadanie-2.yaml)**

![img](img/screenshot_4.png)