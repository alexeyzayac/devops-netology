# Домашнее задание к занятию 5 «Использование Terraform в команде» - `Заяц Алексей`

### Цели задания

1. Научиться использовать remote state с блокировками.
2. Освоить приёмы командной работы.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Любые ВМ, использованные при выполнении задания, должны быть прерываемыми, для экономии средств.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
Убедитесь что ваша версия **Terraform** ~>1.12.0
Пишем красивый код, хардкод значения не допустимы!

------
### Задание 0
1. Прочтите статью: https://neprivet.com/
2. Пожалуйста, распространите данную идею в своем коллективе.

------

### Задание 1

1. Возьмите код:
- из [ДЗ к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/src),
- из [демо к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1).
2. Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект.
3. Перечислите, какие **типы** ошибок обнаружены в проекте (без дублей).

### Результат:

Через докер, команда **tflint**: 
```bash
docker run --rm --tty -v "$(pwd)/src:/tflint" -w /tflint ghcr.io/terraform-linters/tflint

docker run --rm --tty -v "$(pwd)/demonstration1/vms:/tflint" -w /tflint ghcr.io/terraform-linters/tflint

docker run --rm --tty -v "$(pwd)/demonstration1/passwords:/tflint" -w /tflint ghcr.io/terraform-linters/tflint
```

![img](img/screenshot_1.png)

Через докер, команда **checkov**: 
```bash
docker run --rm --tty -v "$(pwd)/src:/checkov" -w /checkov bridgecrew/checkov --download-external-modules true --directory /checkov

docker run --rm --tty -v "$(pwd)/demonstration1/vms:/checkov" -w /checkov bridgecrew/checkov --download-external-modules true --directory /checkov

docker run --rm --tty -v "$(pwd)/demonstration1/passwords:/checkov" -w /checkov bridgecrew/checkov --download-external-modules true --directory /checkov
```

![img](img/screenshot_2.png)

**Типы ошибок:**

#### TFLint: 
    * Отсутствует версия для провайдера. (yandex, random_password, template_file)
    * Объявленная, но не используется переменная (vms_ssh_root_key, vm_web_name, vm_db_name, public_key)
    * Указывать репозиторий git в качестве исходного кода модуля без привязки к версии. (https://github.com/udjin10/yandex_compute_instance.git?ref=main)

#### Checkov:
    * CKV_YC_11: Группа безопасности не назначена сетевому интерфейсу
    * CKV_YC_2: Виртуальная машина имеет публичный IP-адрес
    * CKV_TF_1: Источник модуля не использует хэш коммита
    * CKV_TF_2: Источник модуля не использует версионный тег

------

### Задание 2

1. Возьмите ваш GitHub-репозиторий с **выполненным ДЗ 4** в ветке 'terraform-04' и сделайте из него ветку 'terraform-05'.
2. Настройте remote state с встроенными блокировками:
   - Создайте S3 bucket в Yandex Cloud для хранения state (если еще не создан)
   - Создайте service account с правами на чтение/запись в bucket
   - Настройте backend в providers.tf с использованием нового механизма блокировок:
     ```hcl
     terraform {
       required_version = "~>1.12.0"
       
       backend "s3" {
         bucket  = "ваш-bucket-name"
         key     = "terraform.tfstate"
         region  = "ru-central1"
         
         # Встроенный механизм блокировок (Terraform >= 1.6)
         # Не требует отдельной базы данных!
         use_lockfile = true
         
         endpoints = {
           s3 = "https://storage.yandexcloud.net"
         }
         
         skip_region_validation      = true
         skip_credentials_validation = true
         skip_requesting_account_id  = true
         skip_s3_checksum            = true
       }
     }
     ```
   - Выполните `terraform init -migrate-state` для миграции state в S3
   - Предоставьте скриншоты процесса настройки и миграции
3. Закоммитьте в ветку 'terraform-05' все изменения.
4. Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
5. Пришлите ответ об ошибке доступа к state (блокировка должна сработать автоматически).
6. Принудительно разблокируйте state командой `terraform force-unlock <LOCK_ID>`. Пришлите команду и вывод.

**Примечание:** В Terraform >= 1.6 появился встроенный механизм блокировок через `use_lockfile = true`. 
Это упрощает настройку - больше не нужно создавать отдельную базу данных (YDB в режиме DynamoDB) для хранения блокировок.
Lock-файл создается автоматически в том же S3 bucket рядом с state-файлом с именем `<key>.lock.info`.

### Результат:

[Настройки backend в providers.tf](src-04/00_providers.tf)

![img](img/screenshot_3.png)

![img](img/screenshot_4.png)