Подгатовка к заданию №5

--Первый коммит
///////
Самостоятельное задание.
Исследовать способ подключения к internalhost в
одну команду из вашего рабочего устройства,
проверить работоспособность найденного решения и
внести его в README.md в вашем репозитории
Решение:
ssh -i ~/.ssh/appuser -A appuser@35.205.20.206 ssh appuser@10.132.0.3
или 
ssh -o ProxyCommand='ssh -W %h:%p appuser@35.205.20.206' appuser@10.132.0.3
///////
Доп. задание: Предложить вариант решения для
подключения из консоли при помощи команды вида
ssh internalhost из локальной консоли рабочего
устройства, чтобы подключение выполнялось по
алиасу internalhost и внести его в README.md в вашем
репозитории
Решение:
Создать файл config в ~/.ssh/
Прописать в него:

HOST bastion
    IdentityFile ~/.ssh/appuser
    User appuser
    HostName 35.205.20.206

HOST internalhost
    IdentityFile ~/.ssh/appuser
    User appuser
    HostName 10.132.0.3
    ProxyCommand ssh bastion -W %h:%p

Домашняя работа 06

Команда для запуска инстанса с использованием локального startup script

gcloud compute instances create reddit-app-n2\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --zone=europe-west3-b \
  --metadata-from-file startup-script=startup_script.sh

Дополнительное задание:

Команда для запуска инстанса с использованием startup script из gs (предварительно создан региональный сегмент и загружен скрипт)

gcloud compute instances create reddit-app-n2\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --zone=europe-west3-b \
  --metadata startup-script-url=https://storage.cloud.google.com/scriptsstartup/startup_script.sh

