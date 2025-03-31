NAME=inception

all: up

up:
	docker compose -f src/docker-compose.yml up --build -d

down:
	docker compose -f src/docker-compose.yml down

clean: down
	docker system prune -af

re: clean up