NAME = inception
SRCDIR = srcs
DOCKER = docker compose --project-directory $(SRCDIR) -p $(NAME)

ifeq (shell, $(firstword $(MAKECMDGOALS)))
  CONTAINER := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(CONTAINER):;@:)
endif

up:
	$(DOCKER) up -d

down:
	$(DOCKER) down

logs:
	$(DOCKER) logs

shell:
	docker exec -it $(CONTAINER) /bin/bash

fclean: down
	docker rm -vf $(shell docker ps -aq)
	docker rmi -f $(shell docker images -aq)

re: fclean up

.PHONY: up clean fclean re

# EDITAR ETC/HOSTS DE VM EN 42