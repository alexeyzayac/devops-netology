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

- ```.terraform/``` — будет игнорироваться вся директория .terraform и всё её содержимое.

- ```*.tfstate``` — будут игнорироваться все файлы, имя которых заканчивается на .tfstate.

- ```*.tfstate.*``` — будут игнорироваться все файлы, имя которых начинается с .tfstate. и имеет любое продолжение.

- ```crash.log``` - будет игнорироваться файл с точным именем crash.log.

- ```crash.*.log``` — будут игнорироваться все файлы, имя которых начинается с crash., затем содержит любую последовательность символов, и заканчивается на .log.

- ```*.tfvars``` — будут игнорироваться все файлы, имя которых заканчивается на .tfvars.

- ```*.tfvars.json``` — будут игнорироваться все файлы, имя которых заканчивается на .tfvars.json.

- ```override.tf``` — будет игнорироваться файл с точным именем override.tf.

- ```override.tf.json``` - будет игнорироваться файл с точным именем override.tf.json.

- ```*_override.tf``` — будут игнорироваться все файлы, имя которых оканчивается на _override.tf.

- ```*_override.tf.json``` - будут игнорироваться все файлы, имя которых оканчивается на _override.tf.json.

- ```.terraform.tfstate.lock.info``` - будет игнорироваться файл с точным именем .terraform.tfstate.lock.info.

- ```.terraformrc``` — будет игнорироваться файл с точным именем .terraformrc.

- ```terraform.rc``` — будет игнорироваться файл с точным именем terraform.rc.

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

