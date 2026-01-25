# Домашнее задание к занятию 1 «Системы контроля версий» - `Заяц Алексей`

### Цель задания

В результате выполнения задания вы: 

* научитесь подготоваливать новый репозиторий к работе;
* сохранять, перемещать и удалять файлы в системе контроля версий.  


### Чеклист готовности к домашнему заданию

1. Установлена консольная утилита для работы с Git.


### Инструкция к заданию

1. Домашнее задание выполните в GitHub-репозитории. 
2. В личном кабинете отправьте на проверку ссылку на ваш репозиторий с домашним заданием.
3. Любые вопросы по решению задач задавайте в разделе "Вопросы по заданию".


### Дополнительные материалы для выполнения задания

1. [GitHub](https://github.com/).
2. [Инструкция по установке Git](https://git-scm.com/downloads).
3. [Книга про  Git на русском языке](https://git-scm.com/book/ru/v2/) - рекомендуем к обязательному изучению главы 1-7.
   
------

## Задание 1. Создать и настроить репозиторий для дальнейшей работы на курсе

### Создание репозитория и первого коммита

Version Control System, VCS

```bash
git clone https://github.com/alexeyzayac/devops-netology.git
cd devops-netology
git config --global user.name alexeyzayac
git config --global user.email alexeyzayac@icloud.com
git status
echo "Version Control System, VCS" > README.md
git status
git diff
git diff --staged
git add README.md
git diff
git diff --staged
git commit -m 'First commit'
git status
git diff
git diff --staged
```

### Создание файлов `.gitignore` и второго коммита

```bash
touch .gitignore
git add .gitignore
git commit -m 'Added gitignore'
```

В будущем не будут отслеживаться и попадать в git:

1. Локальная директория .terraform/, создаваемая Terraform для плагинов и модулей.

2. Файлы состояния Terraform (*.tfstate, *.tfstate.*), так как они содержат текущее состояние инфраструктуры.

3. Временные lock-файлы состояния, создаваемые во время выполнения terraform apply.

4. Файлы с переменными (*.tfvars, *.tfvars.json), поскольку они часто содержат пароли, ключи и другие секреты.

5. Override-файлы (override.tf, *_override.tf и их JSON-аналоги), используемые для локальных изменений конфигурации.

6. Конфигурационные файлы Terraform CLI (.terraformrc, terraform.rc).

7. Логи аварийного завершения Terraform (crash.log, crash.*.log).

8. Опционально могут игнорироваться файлы планов и графов Terraform, если соответствующие строки будут раскомментированы в .gitignore.

### Эксперимент с удалением и перемещением файлов (третий и четвёртый коммит)

```bash
echo "will_be_deleted" > will_be_deleted.txt
echo "will_be_moved" > will_be_moved.txt
git add will_be_deleted.txt will_be_moved.txt
git commit -m "Prepare to delete and move"
git rm will_be_deleted.txt
git mv will_be_moved.txt has_been_moved.txt
git status
git commit -m "Moved and deleted"
```

### Проверка изменения

```bash
ufo@NEXA-HOST:~/devops-netology (main)$ git log --oneline
c0b1647 (HEAD -> main) Moved and deleted
4916b18 Prepare to delete and move
917799a Added gitignore
764b47a First commit
954c68f (origin/main, origin/HEAD) Initial commit
```

### Отправка изменений в репозиторий

```bash
git push
```

