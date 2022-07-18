# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmondell <mmondell@student.42quebec.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/07/14 14:43:39 by mmondell          #+#    #+#              #
#    Updated: 2022/07/15 15:36:20 by mmondell         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: up

up: 
	sudo mkdir -p /home/mmondell/data/mariadb
	sudo mkdir -p /home/mmondell/data/wordpress
	@docker-compose -f srcs/docker-compose.yml up -d

down:
	@docker-compose -f srcs/docker-compose.yml down

build:
	@docker-compose -f srcs/docker-compose.yml build 

clean:
	@docker-compose -f srcs/docker-compose.yml down --rmi all

vclean:
	sudo rm -rf /home/mmondell/data/mariadb/*
	sudo rm -rf /home/mmondell/data/wordpress/*
	@docker volume rm $(shell docker volume ls -q)

fclean:	clean vclean

re: fclean all

.PHONY: all up down build clean vclean fclean re
