# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmondell <mmondell@student.42quebec.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/24 10:41:03 by mmondell          #+#    #+#              #
#    Updated: 2022/07/16 07:03:43 by mmondell         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: up

up:
	sudo mkdir -p /home/mmondell/data/mariadb/
	sudo mkdir -p /home/mmondell/data/wordpress/
	@docker-compose -f srcs/docker-compose.yml up --build

down:
	@docker-compose -f srcs/docker-compose.yml down

build:
	@docker-compose -f srcs/docker-compose.yml build

clean:
	sudo rm -rf /home/mmondell/data/mariadb/*
	sudo rm -rf /home/mmondell/data/wordpress/*
	@docker-compose -f srcs/docker-compose.yml down --rmi all

vclean:
	@docker volume rm $(shell docker volume ls -q)

state:
	sudo docker ps -a
	sudo docker images
	sudo docker volume ls

fclean:	clean vclean

re: fclean all

.PHONY: all up down build clean vclean fclean re
