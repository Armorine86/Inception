# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmondell <mmondell@student.42quebec.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/24 10:41:03 by mmondell          #+#    #+#              #
#    Updated: 2022/07/07 22:08:48 by mmondell         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ENV_FILE=srcs/.env

all: up

up:
	@docker-compose --env-file $(ENV_FILE) -f srcs/docker-compose.yml up -d

down:
	@docker-compose -f srcs/docker-compose.yml down

build:
	@docker-compose --env-file $(ENV_FILE) -f srcs/docker-compose.yml build

clean:
	@docker-compose -f srcs/docker-compose.yml down --rmi all

vclean:
	@docker volume rm $(shell docker volume ls -q)

fclean:	clean vclean

re: fclean all

.PHONY: all up down build clean vclean fclean re
