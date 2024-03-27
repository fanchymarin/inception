NAME = inception
SRCDIR = srcs
DOCKER = docker compose --project-directory $(SRCDIR) -p $(NAME)

ifeq (shell, $(firstword $(MAKECMDGOALS)))
  CONTAINER := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(CONTAINER):;@:)
endif

all:
	$(DOCKER) up -d

clean:
	$(DOCKER) down

logs:
	$(DOCKER) logs

shell:
	docker exec -it $(CONTAINER) /bin/bash

fclean: clean
	docker rm -vf $(shell docker ps -aq)
	docker rmi -f $(shell docker images -aq)

re: fclean all

.PHONY: all clean fclean re

# EDITAR ETC/HOSTS DE VM EN 42