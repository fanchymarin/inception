NAME = inception
SRCDIR = srcs
DOCKER = docker compose --project-directory $(SRCDIR) -p $(NAME)

include srcs/.env

ifeq (shell, $(firstword $(MAKECMDGOALS)))
  CONTAINER := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(CONTAINER):;@:)
endif

all: setup up

up:
	$(DOCKER) up -d --build

down:
	$(DOCKER) down

log:
	$(DOCKER) logs -f

shell:
	docker exec -it $(CONTAINER) /bin/bash

clean: down
	docker rmi -f $(shell docker images -aq)
	docker volume rm $(shell docker volume ls -q)

fclean: clean
	docker system prune -af
	sudo sed -i.backup 's/localhost.*/localhost/g' /etc/hosts
	rm -rf ${HOME}/data

setup:
	mkdir -p ${HOME}/data
	mkdir -p ${HOME}/data/mariadb
	mkdir -p ${HOME}/data/wordpress
	mkdir -p ${HOME}/data/socket
	sudo sed -i.backup 's/localhost.*/localhost www.${DOMAIN_NAME} ${DOMAIN_NAME}/g' /etc/hosts

re: fclean all

.PHONY: up clean fclean re