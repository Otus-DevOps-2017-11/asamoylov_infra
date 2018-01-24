#!/bin/sh
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
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
