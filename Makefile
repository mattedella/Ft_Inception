
up:
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up --build -d

down:
	@docker-compose -f srcs/docker-compose.yml down -v

status:
	@docker ps

re:
	@make down
	@sleep 100
	@make up
