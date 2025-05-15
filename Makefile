
up:
	@clear
	@echo "Starting up the containers..."
	@echo "----------------------------------------"
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up --build -d

down:
	@clear
	@echo "Stopping and removing the containers..."
	@echo "----------------------------------------"
	@docker-compose -f srcs/docker-compose.yml down -v

status:
	@clear
	@echo "Checking the status of the containers..."
	@echo "----------------------------------------"
	@docker ps

re:
	@make down
	@sleep 2
	@make up
