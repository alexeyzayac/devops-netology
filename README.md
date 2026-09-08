# Домашнее задание к занятию 12 "`Troubleshooting`" - `Заяц Алексей`

### Цель задания

Устранить неисправности при деплое приложения.

### Чеклист готовности к домашнему заданию

1. Кластер K8s.

### Задание. При деплое приложение web-consumer не может подключиться к auth-db. Необходимо это исправить

1. Установить приложение по команде:
```shell
kubectl apply -f https://raw.githubusercontent.com/netology-code/kuber-homeworks/main/3.5/files/task.yaml
```
2. Выявить проблему и описать.
3. Исправить проблему, описать, что сделано.
4. Продемонстрировать, что проблема решена.

### Решение:

#### Проблема 1: Отсутствуют Namespace web и data

![screenshot_1](./img/screenshot_1.png)

*Для решения создан  с помощью манифеста [yaml](./kube/namespace.yaml) с Namespace*

```bash
kubectl apply -f namespace.yaml
```

#### Результат:
*Namespace созданы, ошибка исчезла.*

---

#### Проблема 2: Поды в web не могут обратиться к сервису auth-db

![screenshot_2](./img/screenshot_2.png)

Выполнен анализ через:

```bash
kubectl get pods -n web && kubectl get pods -n data
kubectl get svc -n data
kubectl describe pods -n web web-consumer-xxxxxxxx-xxx
kubectl describe services -n data auth-db
```

#### Причина:

*Поды в namespace web пытаются обратиться к сервису auth-db по короткому имени, но сервис находится в другом namespace: data.*

`kubectl describe pods -n web web-consumer-xxxxxxxx-xxx`
```yaml
Namespace:        web
Labels:           app=web-consumer
                  pod-template-hash=6c5f7cc594
    Command:
      sh
      -c
      while true; do curl auth-db; sleep 5; done
```
`kubectl describe services -n data auth-db`
```yaml
Name:                     auth-db
Namespace:                data
```

**Исправление:**
*Необхдимо обновить Deployment web-consumer в namespace web, заменив команду на полное DNS-имя сервиса:*

```bash
kubectl edit deployment web-consumer -n web
```
```yaml
    Command:
      sh
      -c
      while true; do curl auth-db.data.svc.cluster.local; sleep 3; done
```

#### Результат:
*DNS-запрос теперь успешно резолвится, но поды всё равно не запускаются из-за следующей проблемы.*

---

**Проблема 3: Образ `radial/busyboxplus:curl` не загружается**

![screenshot_3](./img/screenshot_3.png)

#### Причина:
*Используемый образ имеет устаревший формат манифеста, который больше не поддерживается современным контейнерами. Из-за этого образ не может скачаться.*

```yaml
    Image:         busybox:latest
    Command:
      sh
      -c
      until nslookup auth-db.data.svc.cluster.local; do echo "Waiting for auth-db"; sleep 3; done
```

#### Результат:
*Образ успешно загрузился, контейнер запустился. После успешного выполнения nslookup команда завершается, и контейнер переходит в состояние `Completed`. Из-за политики перезапуска restartPolicy: Always, устанавливается по умолчанию, под перезапускается, и этот цикл повторяется. Остальные два образа имеют старый образ для контейнера, поэтому они висят с ошибклй: `ImagePullBackOff`*

![screenshot_4](./img/screenshot_4.png)
