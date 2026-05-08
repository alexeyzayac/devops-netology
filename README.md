# Домашнее задание к занятию 1 «Введение в Ansible» - Заяц Алексей

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.
6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.
13. Предоставьте скриншоты результатов запуска команд.

### Решение:

#### Задание 1
```bash
$ ansible-playbook -i inventory/test.yml site.yml
    "msg": 12
```

#### Задание 2
```bash
$ ansible-playbook -i inventory/test.yml site.yml
    "msg": "all default fact"
```

#### Задание 3

[Dockerfile для создания Image](docker/)

```bash
$ docker run -d --name ubuntu ubuntu-ansible:latest
$ docker run -d --name centos7 centos-ansible:lateste
```

#### Задание 4

![img](img/screenshot_1.png)

#### Задание 5-6

![img](img/screenshot_2.png)

#### Задание 7

```bash
$ ansible-vault encrypt group_vars/deb/examp.yml
$ ansible-vault encrypt group_vars/el/examp.yml
```

#### Задание 8

```bash
$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
```

#### Задание 9

```bash
$ ansible-doc -t connection -l | grep local
ansible.builtin.local                execute on controller
```

#### Задание 10

![img](img/screenshot_3.png)

---

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

### Решение:

#### Задание 1
```bash
$ ansible-vault decrypt deb/examp.yml
$ ansible-vault decrypt el/examp.yml
```

#### Задание 2
```bash
ansible-vault encrypt_string
```

#### Задание 3
```bash
ansible-playbook -i inventory/prod.yml --limit local site.yml --ask-vault-pass
```

![img](img/screenshot_4.png)

#### Задание 4

[Dockerfile для создания Image Fedora](docker/Dockerfile_fedora)

```bash
$ docker run -d --name fedora fedora-ansible:latest
$ ansible-playbook -i inventory/prod.yml --limit fedora site.yml --ask-vault-pass
```

![img](img/screenshot_5.png)

#### Задание 5

[Скрипт для автома](script.sh)