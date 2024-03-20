NAME = inception
SRCDIR = srcs

all:
	docker compose --project-directory $(SRCDIR) -p $(NAME) up -d

clean:
	docker compose --project-directory $(SRCDIR) -p $(NAME) down

fclean: clean
	docker rmi $(shell docker images --filter=reference="$(NAME)-*" -q)

re: fclean all

.PHONY: all clean fclean re