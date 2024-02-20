# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jkollner <jkollner@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/20 09:44:32 by jkollner          #+#    #+#              #
#    Updated: 2024/02/20 10:42:41 by jkollner         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
ENV:=srcs/.env

all: $(ENV) build up

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

.PHONY: all clean fclean re up down build
