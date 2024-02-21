# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jkollner <jkollner@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/20 09:44:32 by jkollner          #+#    #+#              #
#    Updated: 2024/02/21 12:18:36 by jkollner         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
ENV:=srcs/.env
DATA:=./data

HOSTNAME:=jkollner.42.fr

all: prerequisits build up

prerequisits: $(ENV) $(DATA)

up:
	docker-compose -f $(DOCKER_COMPOSE_FILE) --env-file $(ENV) up --build

down:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

build:
	docker-compose -f $(DOCKER_COMPOSE_FILE) build

$(ENV):
	@echo "Creating ENV file..."
	@echo "--- MySql/Mariadb ---"
	@read -p "Enter DB_DATABASE: " value; echo DB_DATABASE=$$value >> $(ENV)
	@read -p "Enter DB_HOSTNAME: " value; echo DB_HOSTNAME=$$value >> $(ENV)
	@read -p "Enter DB_USER: " value; echo DB_USER=$$value >> $(ENV)
	@read -s -p "Enter DB_PASSWORD: " value; echo DB_PASSWORD=$$value >> $(ENV)

fclean:
	@rm -rf $(HOME)/data
	@rm -f $(ENV)
	@docker system prune --all --force --volumes
	@docker volume prune --force
	@docker network prune --force
	@if [ "`docker volume ls -q`" ]; then \
		docker volume rm `docker volume ls -q`; \
	fi
	@echo "Fully Cleaned"

update_host:
	@echo "Updating /etc/hosts..."
	@grep -q 'jkollner.42.fr' /etc/hosts && echo 'Domain name already set' || echo "127.0.0.1 jkollner.42.fr" >> /etc/hosts

$(DATA):
	@echo "Creating data directory..."
	@mkdir -p $(HOME)/data/wordpress_db
	@mkdir -p $(HOME)/data/wordpress_files
	@mkdir -p $(HOME)/data/mariadb

.PHONY: all clean fclean re up down build
