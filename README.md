# Домашнее задание к занятию 2 "`Вычислительные мощности. Балансировщики нагрузки`" - `Заяц Алексей`

## Подготовка к выполнению задания

1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашних заданий.

## Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.

Полезные документы:

- [Compute instance group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance_group).
- [Network Load Balancer](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer).
- [Группа ВМ с сетевым балансировщиком](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer).

## Результат:

**Код для поднятия инфраструктуры находиться в [директории](./infra/)**

Были обновлены конфигурации:
* 01_variables.tf
* 01_variables_vms.tf
* 03_security_group.tf
* 05_compute_instance.tf
* 99_outputs.tf
* terraform.tfvars

Были созданны конфигурации:
* 01_locals.tf
* 06_storage.tf
* 07_instance_group.tf
* 08_load_balancer.tf

### `outputs` послле `terraform apply`:

![screenshot_1](./img/screenshot_1.png)

### Поднятые машины: 

![screenshot_2](./img/screenshot_2.png)

### Проверка картинки из бакета:

![screenshot_3](./img/screenshot_3.png)

### Проверка работы балансировшика:

![screenshot_4](./img/screenshot_4.png)
![screenshot_5](./img/screenshot_5.png)

### Удаление машин, в группе виртуальных машин:

![screenshot_6](./img/screenshot_6.png)

### Поднятые машины, обновленные:

![screenshot_7](./img/screenshot_7.png)

### Проверка работы балансировшика c IP новой машины:

![screenshot_8](./img/screenshot_8.png)
