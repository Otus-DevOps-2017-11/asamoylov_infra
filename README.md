# Задание №5

Самостоятельное задание.
Исследовать способ подключения к internalhost в
одну команду из вашего рабочего устройства,
проверить работоспособность найденного решения и
внести его в README.md в вашем репозитории
Решение:
```ssh -i ~/.ssh/appuser -A appuser@35.205.20.206 ssh appuser@10.132.0.3```
или 
```ssh -o ProxyCommand='ssh -W %h:%p appuser@35.205.20.206' appuser@10.132.0.3```
///////
## Доп. задание: Предложить вариант решения для
подключения из консоли при помощи команды вида
ssh internalhost из локальной консоли рабочего
устройства, чтобы подключение выполнялось по
алиасу internalhost и внести его в README.md в вашем
репозитории

Решение:
Создать файл config в ~/.ssh/
Прописать в него:

```
HOST bastion
    IdentityFile ~/.ssh/appuser
    User appuser
    HostName 35.205.20.206

HOST internalhost
    IdentityFile ~/.ssh/appuser
    User appuser
    HostName 10.132.0.3
    ProxyCommand ssh bastion -W %h:%p
```

# Домашняя работа 06

Команда для запуска инстанса с использованием локального startup script
```
gcloud compute instances create reddit-app-n2\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --zone=europe-west3-b \
  --metadata-from-file startup-script=startup_script.sh
```

## Дополнительное задание:

Команда для запуска инстанса с использованием startup script из gs (предварительно создан региональный сегмент и загружен скрипт)
```
gcloud compute instances create reddit-app-n2\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --zone=europe-west3-b \
  --metadata startup-script-url=https://github.com/Otus-DevOps-2017-11/asamoylov_infra/blob/Infra-2/startup_script.sh
```
# Домашняя работа 07

## Самостоятельное задание № 1

Для параметризации пользовательские переменные id_project, source_image_family, machine указаны в разделе variables конфигурационного файла. Переменные указываются в файле variables.json. Пример заполнения variables.json.example

## Самостоятельное задание № 2

Дополнительные опции параметризации
```
Описание образа - "image_description",
Размер и тип диска - "disk_size", "disk_type"
Название сети - "network"
Теги - "tags"
```

# Домашняя работа №8

## Практика IaC с использованием Terraform
### Задание №1

В файле переменных input.tf определены переменные 
1. private_key_path- путь к приватному ключу для подключения провижинеров
2. zone - зона инстанса
3. Отформатированы конфигурационные файлы командой terraform fmt 
4. terraform.tfvars.example - переменные для образца

## Самостоятельное задание
### Задание №2.

Добавление ключей через код:

```
resource "google_compute_project_metadata" "sshkey1" {
  metadata {
    ssh-keys = "appuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
  }
}
```
Второй ключ можно добавить через разделитель \n
 
Задание со звездочкой * Какие проблемы вы обнаружили?

Наличие ключа в инстансе отлючает проектные ключи.
Тераформ удалил созданный вручную ключ.

# Домашняя работа №9

1. Создал два отдельных образа reddit-db-base и reddit-app-base для соответствующих инстансов, вынес в переменные.
2. Создал два отдельных конфига app.tf и db.tf
3. В соответствии с задание введена модульность: app, db, vpc
4. Все конф. файлы параметризованы.
5. Создал окружения stage и prod для разделения прав развёртывания по ip.
6. Добавил провиженеры в app/main.tf и db/main.tf
...

# Домашняя работа №10

1. Выполнил все действия по уроку.
2. Не удалось добиться работы json файла. 

# Домашняя работа №11

## Создано несколько плейбуков для настройки и деплоя инстансов db и app
`ansible/reddit_app_one_play.yml` - плейбуки для db и app в одном `play-book`, тегами разграничены db, app, deploy<br>
`ansible/reddit_app_multiple_plays.yml` - также плейбуки для настройки БД и приложения в одном файле, но разные `play-book`, тегами разграничены db, app, deploy


## Настройки конфигов БД шаблонизированы (ansible/templates)
- `ansible/templates/mongod.conf.j2` - конфиг mongodb
- `ansible/templates/db_config.j2` - файл, содержащий переменные, необходимые для приложения (`puma.service`)

## Unit файл приложения `puma.service` вынесен в ansible/files
Через EnvironmentFile получили доступ к БД (DATABASE_URL)

## Проверка и запуск плейбуков reddit_app_one_play, reddit_app_multiple_plays
db
```
ansible-playbook reddit_app_one_play.yml --tags db-tag --check
ansible-playbook reddit_app_one_play.yml --tags db-tag
```
```
ansible-playbook reddit_app_multiple_plays.yml --tags db-tag --check
ansible-playbook reddit_app_multiple_plays.yml --tags db-tag
```

app
```
ansible-playbook reddit_app_one_play.yml --tags app-tag --check
ansible-playbook reddit_app_one_play.yml --tags app-tag
```
```
ansible-playbook reddit_app_multiple_plays.yml --tags app-tag --check
ansible-playbook reddit_app_multiple_plays.yml --tags app-tag
```

deploy
```
ansible-playbook reddit_app_one_play.yml --tags deploy-tag --check
ansible-playbook reddit_app_one_play.yml --tags deploy-tag
```
```
ansible-playbook reddit_app_multiple_plays.yml --tags deploy-tag --check
ansible-playbook reddit_app_multiple_plays.yml --tags deploy-tag
```

## Далее созданы плейбуки в отдельных файлых для db, app, deploy
- `ansible/db.yml`
- `ansible/app.yml`
- `ansible/deploy.yml`

## Затем все 3 плейбука (db, app, deploy) были собраны в одном - `site.yml`
```
- import_playbook: db.yml
- import_playbook: app.yml
- import_playbook: deploy.yml
```

Проверка и запуск плейбука site.yml
```
ansible-playbook site.yml --check
```
```
ansible-playbook site.yml
```

## Реализованы плейбуки для `provisioner`s образов `packer`
- `ansible/packer_db.yml`
- `ansible/packer_app.yml`

Данные плейбуки указаны в секции `provisioner` файлов сборки образов
- `packer/db.json`
- `packer/app.json`

После чего были пересозданы образы, пересозданы инстансы окружения `stage` и
сконфигурированы инстансы db & app
```
ansible-playbook site.yml --check
```
```
ansible-playbook site.yml
```