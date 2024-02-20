# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jkollner <jkollner@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/02/20 09:44:32 by jkollner          #+#    #+#              #
#    Updated: 2024/02/20 09:47:48 by jkollner         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

all: build up

up:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up

down:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

build:
	docker-compose -f $(DOCKER_COMPOSE_FILE) build

.PHONY: all clean fclean re up down build
