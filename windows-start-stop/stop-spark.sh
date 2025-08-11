#!/bin/bash
# Navigate to docker/ directory containing docker-compose.yml
PROJECT_ROOT="$(dirname "$(realpath "$0")")/.."
DOCKER_DIR="$PROJECT_ROOT/docker"

# Check if docker-compose.yml exists
if [ ! -f "$DOCKER_DIR/docker-compose.yml" ]; then
  echo "Error: docker-compose.yml not found in $DOCKER_DIR"
  exit 1
fi

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
  echo "Error: Docker is not running. Start Docker in WSL2 with 'sudo service docker start'"
  exit 1
fi

# Stop Spark cluster
cd "$DOCKER_DIR"
docker compose down
if [ $? -eq 0 ]; then
  echo "Spark cluster stopped"
else
  echo "Error: Failed to stop Spark cluster. Check logs with 'docker logs spark-master'"
  exit 1
fi