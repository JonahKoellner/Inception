#!/bin/bash

sudo apt-get install curl -y
sudo apt-get install build-essential -y
sudo apt-get install vim -y
sudo apt-get install mariadb-server -y

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo groupadd docker

sudo usermod -aG docker vboxuser
sudo usermod -aG sudo vboxuser

sudo shutdown -r -f 00

newgrp docker

docker run hello-world
