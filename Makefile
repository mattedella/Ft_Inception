
up:
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up --build -d

down:
	@docker-compose -f srcs/docker-compose.yml down

status:
	@docker ps

re:
	@make down
	@make up
