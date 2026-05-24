Lighthouse
==========

Устанавливает и настраивает **Lighthouse** (от VKCOM)

Переменные
--------------

| vars | Описание |
|--------|--------|
| lighthouse_version | Ветка/тег репозитория Lighthouse |
| lighthouse_repo | URL репозитория |
| lighthouse_nginx_port | Порт, на котором Nginx будет слушать запросы |
| lighthouse_server_name | Значение server_name в конфиге Nginx |

Тэги
----

- lighthouse – все задачи роли
- system – обновление кэша пакетов
- packages – установка Git и Nginx
- nginx_config – настройка конфигурации Nginx


План действий
-------------

    - hosts: servers
      roles:
         - { role: lighthouse }

Лицензия
--------

MIT

Автор
-----

Заяц Алексей