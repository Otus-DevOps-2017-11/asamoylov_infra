<<<<<<< HEAD
#!/bin/sh
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list
=======
#!/bin/bash

# Установка Ruby
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
# Установка Mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
>>>>>>> 14a1200ec9c477440f41909ea03876c3dc712e3f
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
<<<<<<< HEAD
cd ~
git clone https://github.com/Otus-DevOps-2017-11/reddit.git
cd reddit
bundle install
puma -d
if ps aux | grep puma | grep -vq grep; then
  echo "Puma start"
else
  echo "Puma stop"
fi
=======
# Запуск приложения
git clone https://github.com/Otus-DevOps-2017-11/reddit.git
cd reddit && bundle install
puma -d
>>>>>>> 14a1200ec9c477440f41909ea03876c3dc712e3f
