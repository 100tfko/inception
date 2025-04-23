NAME = inception

# Default target (runs 'up')
all: up

# Start containers with proper directory permissions
up: hosts
	mkdir -p /home/lcuevas/data/mariadb /home/lcuevas/data/wordpress
	chmod -R 755 /home/lcuevas/data  # Ensure proper permissions
	docker compose -f srcs/docker-compose.yml up --build -d

# Ensure /etc/hosts contains the necessary domain mapping
hosts:
	@echo "Checking /etc/hosts for lcuevas.42.fr..."
	@HOST_ENTRY="127.0.0.1	lcuevas.42.fr"; \
	if ! grep -q "$$HOST_ENTRY" /etc/hosts; then \
		echo "Adding $$HOST_ENTRY to /etc/hosts"; \
		echo "$$HOST_ENTRY" | sudo tee -a /etc/hosts > /dev/null; \
	else \
		echo "$$HOST_ENTRY already exists."; \
	fi

# Stop containers
down:
	docker compose -f srcs/docker-compose.yml down

# Full cleanup (containers, images, volumes)
clean: down
	docker volume rm -f $$(docker volume ls -q) || true
	docker system prune -af --volumes
	sudo rm -rf /home/lcuevas/data

# Rebuild from scratch
re: clean up

.PHONY: all up down clean re hosts
