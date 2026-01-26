# Домашнее задание к занятию 2 «Основы Git» - `Заяц Алексей`

### Цель задания

В результате выполнения задания вы:

* научитесь работать с Git, как с распределённой системой контроля версий; 
* сможете создавать и настраивать репозиторий для работы в GitHub, GitLab и Bitbucket; 
* попрактикуетесь работать с тегами;
* поработаете с Git при помощи визуального редактора.

### Чеклист готовности к домашнему заданию

1. Установлена консольная утилита для работы с Git.
2. Есть возможность зарегистрироваться на GitHub, GitLab.
3. Регистрация на Bitbucket не является обязательной. 


### Инструкция к заданию

1. В личном кабинете отправьте на проверку ссылки на ваши репозитории.
2. Любые вопросы по решению задач задавайте в разделе "Вопросы по заданию".

------

## Задание 1. Знакомимся с GitLab

В данном задание ветка **main** = **14.01_version_control_system**

[Репозиторий GitLab](https://gitlab.com/alexeyzayac/devops-netology)

Вывод команды git remote -v:

```bash
ufo@NEXA-HOST:~/devops-netology (14.01_version_control_system)$ git remote -v
origin  https://github.com/alexeyzayac/devops-netology.git (fetch)
origin  https://github.com/alexeyzayac/devops-netology.git (push)
```

Добавляем этот репозиторий, как дополнительный:

```bash
git remote add gitlab https://gitlab.com/alexeyzayac/devops-netology.git
git push -u gitlab 14.01_version_control_system
```

Повторный вывод команды git remote -v:

```bash
ufo@NEXA-HOST:~/devops-netology (14.01_version_control_system)$ git remote -v
gitlab  https://gitlab.com/alexeyzayac/devops-netology.git (fetch)
gitlab  https://gitlab.com/alexeyzayac/devops-netology.git (push)
origin  https://github.com/alexeyzayac/devops-netology.git (fetch)
origin  https://github.com/alexeyzayac/devops-netology.git (push)
```

## Задание 2. Теги

**Легковестный тег** - не содержит дополнительной информации, кроме указания на коммит.

```bash
git tag v0.0
git push origin v0.0
git push gitlab v0.0
```

**Аннотированный тег** - отображается с автором, датой и сообщением.

```bash
git tag -a v0.1 -m "Release version 0.1"
git push origin v0.1
git push gitlab v0.1
```

[Тэги GitHub](https://github.com/alexeyzayac/devops-netology/tags)

[Тэги GitLab](https://gitlab.com/alexeyzayac/devops-netology/-/tags)

## Задание 3. Ветки 

Создание веток:

```bash
git log —oneline
git checkout 4916b18
git switch -c fix
git push -u origin fix
echo "New line" >> README.md
git commit -am "Update README.md with new line"
git push -u origin fix
git log --oneline --graph --all
```

![img](img/screenshot_1.png)
![img](img/screenshot_2.png)