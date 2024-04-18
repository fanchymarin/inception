NAME = inception
SRCDIR = srcs
DOCKER = docker compose --project-directory $(SRCDIR) -p $(NAME)

COLOUR_GREEN=\033[0;32m
COLOUR_RED=\033[0;31m
COLOUR_BLUE=\033[0;34m
END_COLOUR=\033[0m

include srcs/.env

ifeq (shell, $(firstword $(MAKECMDGOALS)))
  CONTAINER := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(CONTAINER):;@:)
endif

all: setup up

up:
	@$(DOCKER) up -d --build
	@echo "$(COLOUR_GREEN)[docker containers up and running]$(END_COLOUR)"

down:
	@$(DOCKER) down
	@echo "$(COLOUR_RED)[docker containers shut down]$(END_COLOUR)"

log:
	$(DOCKER) logs -f

shell:
	docker exec -it $(CONTAINER) /bin/bash

clean: down
	docker rmi -f $(shell docker images -aq)
	docker volume rm $(shell docker volume ls -q)
	@echo "$(COLOUR_RED)[docker resources cleared]$(END_COLOUR)"

fclean: clean
	docker system prune -af
	@echo "$(COLOUR_RED)[docker resources pruned]$(END_COLOUR)"
	@echo "$(COLOUR_BLUE)[sudo password required]$(END_COLOUR)"
	@sudo sed -i.backup 's/localhost.*/localhost/g' /etc/hosts
	@echo "$(COLOUR_RED)[domain name removed from /etc/hosts]$(END_COLOUR)"
	@sudo rm -rf ${HOME}/data
	@echo "$(COLOUR_RED)[data directory deleted]$(END_COLOUR)"

setup:
	@mkdir -p ${HOME}/data/mariadb
	@mkdir -p ${HOME}/data/wordpress
	@mkdir -p ${HOME}/data/socket
	@echo "$(COLOUR_GREEN)[data directory created]$(END_COLOUR)"
	@echo "$(COLOUR_BLUE)[sudo password required]$(END_COLOUR)"
	@sudo sed -i.backup 's/localhost.*/localhost www.${DOMAIN_NAME} ${DOMAIN_NAME}/g' /etc/hosts
	@echo "$(COLOUR_GREEN)[domain name included in /etc/hosts]$(END_COLOUR)"

re: fclean all

.PHONY: up clean fclean re