#!/bin/bash

sudo apt-get install curl
sudo apt-get install build-essential


curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo groupadd docker

sudo usermod -aG docker $USER


newgrp docker

docker run hello-world
