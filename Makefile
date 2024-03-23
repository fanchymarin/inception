NAME = inception
SRCDIR = srcs
DOCKER = docker compose --project-directory $(SRCDIR) -p $(NAME)
IMAGES = $(shell docker images --filter=reference="$(NAME)-*" -q)

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
	docker rmi $(IMAGES)

re: fclean all

.PHONY: all clean fclean re

# EDITAR ETC/HOSTS DE VM EN 42