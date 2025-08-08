# Makefile for managing the Spark Docker cluster

DOCKER_COMPOSE = docker compose -f docker/docker-compose.yml

# Start the Spark cluster in detached mode
up:
	$(DOCKER_COMPOSE) up -d

# Stop and remove all containers
down:
	$(DOCKER_COMPOSE) down

# Restart the Spark cluster
restart:
	$(MAKE) down
	$(MAKE) up

# Stop all running containers (even outside Spark)
stop-all:
	docker stop $$(docker ps -q)

# Run PySpark job
submit:
	docker exec spark-master spark-submit --master spark://spark-master:7077 /opt/spark-app/main.py

# View logs from all Spark containers
logs:
	$(DOCKER_COMPOSE) logs -f

# 📋 List all running containers
ps:
	$(DOCKER_COMPOSE) ps
