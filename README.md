# Домашнее задание к занятию 3 "`Безопасность в облачных провайдерах`" - `Заяц Алексей`

## Подготовка к выполнению задания

Используя конфигурации, выполненные в рамках предыдущих домашних заданий, нужно добавить возможность шифрования бакета.


## Задание 1. Yandex Cloud 

**Что нужно сделать**

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

 - создать ключ в KMS;
 - с помощью ключа зашифровать содержимое бакета, созданного ранее.

Полезные документы:

- [Настройка HTTPS статичного сайта](https://cloud.yandex.ru/docs/storage/operations/hosting/certificate).
- [Object Storage bucket](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/storage_bucket).
- [KMS key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kms_symmetric_key).

## Результат:

**Код для поднятия инфраструктуры находиться в [директории](./infra/)**

Были обновлены конфигурации:
* 04_secrets.tf
* 06_storage.tf

### Созданый симметричный ключ KMS для шифрования бакета:

![screenshot_1](./img/screenshot_1.png)

### Ошибка AccessDenied в браузере:

![screenshot_2](./img/screenshot_2.png)

