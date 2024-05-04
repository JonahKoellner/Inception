# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jkollner <jkollner@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/20 09:44:32 by jkollner          #+#    #+#              #
#    Updated: 2024/03/11 15:37:47 by jkollner         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
ENV:=srcs/.env
DATA:=./data

HOSTNAME:=jkollner.42.fr

all: prerequisits update_host up

prerequisits: $(ENV) $(DATA)

up:
	docker compose -f $(DOCKER_COMPOSE_FILE) --env-file $(ENV) up -d --build

down:
	docker compose -f $(DOCKER_COMPOSE_FILE) down

re: fclean all
# build:
# 	docker-compose -f $(DOCKER_COMPOSE_FILE) build

$(ENV):
	@echo "Creating ENV file..."
	@echo "--- MySql/Mariadb ---"
	@read -p "Enter DB_DATABASE: " value; echo DB_DATABASE=$$value >> $(ENV)
	@read -p "Enter DB_HOSTNAME: " value; echo DB_HOSTNAME=$$value >> $(ENV)
	@read -p "Enter DB_USER: " value; echo DB_USER=$$value >> $(ENV)
	@read -p "Enter DB_PASSWORD: " value; echo DB_PASSWORD=$$value >> $(ENV)
	@read -p "Enter WP_ADMINNAME: " value; echo WP_ADMINNAME=$$value >> $(ENV)
	@read -p "Enter WP_ADMINMAIL: " value; echo WP_ADMINMAIL=$$value >> $(ENV)
	@read -p "Enter WP_ADMINPASS: " value; echo WP_ADMINPASS=$$value >> $(ENV)
	@read -p "Enter WP_USERNAME: " value; echo WP_USERNAME=$$value >> $(ENV)
	@read -p "Enter WP_USERMAIL: " value; echo WP_USERMAIL=$$value >> $(ENV)
	@read -p "Enter WP_USERPASS: " value; echo WP_USERPASS=$$value >> $(ENV)
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
	if [ "$EUID" != 0 ]; then
    		sudo @grep -q '$(HOSTNAME)' /etc/hosts && echo 'Domain name already set' || echo "127.0.0.1	$(HOSTNAME)" >> /etc/hosts
   		exit $?
	fi
	@grep -q '$(HOSTNAME)' /etc/hosts && echo 'Domain name already set' || echo "127.0.0.1	$(HOSTNAME)" >> /etc/hosts

$(DATA):
	@echo "Creating data directory..."
	@mkdir -p $(HOME)/data/wordpress_db
	@mkdir -p $(HOME)/data/wordpress_files
	@mkdir -p $(HOME)/data/mariadb

.PHONY: all clean fclean re up down build
