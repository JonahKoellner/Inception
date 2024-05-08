#!/bin/bash

sudo apt-get install curl
sudo apt-get install build-essential
sudo apt-get install vim
sudo apt-get install mariadb-server

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo groupadd docker

sudo usermod -aG docker vboxuser
sudo usermod -aG sudo vboxuser

sudo shutdown -r -f 00

newgrp docker

docker run hello-world
