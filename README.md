# Apache Spark Local Cluster Setup with Ansible + Docker on WSL2

A clean and minimal local Spark cluster environment for practicing PySpark locally, with:

* 1 Spark Master  
* 1 Spark Worker  
* Docker-managed cluster  
* Ansible automation  
* Optional Spark application folder

---

## Project Structure

```

.
├── README.md
├── inventory/
│   └── hosts
├── ansible/
│   ├── playbook.yml
│   └── teardown.yml
├── docker/
│   └── docker-compose.yml 
└── spark-app/
└── main.py

````

---

## Requirements

* Windows 10/11 with WSL2 (Ubuntu)
* Docker installed and running inside WSL2
* Ansible installed in WSL2

### Check Requirements

```bash
# Check Docker
sudo service docker start
docker info

# Install Ansible if missing
sudo apt update
sudo apt install ansible -y
````

---

## Usage

### --- Option 1: Use these one-liner shortcuts: 

```bash
# sudo apt update
# sudo apt install make -y
make up        # Start cluster via Ansible
make down      # Tear down cluster via Ansible
make start     # Start cluster manually via Docker Compose
make stop      # Stop cluster manually via Docker Compose
make submit    # Submit PySpark job (main.py)
```
### --- Option 2: Using docker compose ---
```bash
docker compose -f docker/docker-compose.yml up -d
docker exec spark-master spark-submit --master spark://spark-master:7077 /opt/spark-app/main.py
docker compose -f docker/docker-compose.yml down
docker compose -f docker/docker-compose.yml ps
```
---

### 🟢 Start Cluster

```bash
ansible-playbook -i inventory/hosts ansible/playbook.yml --ask-become-pass
```

This will:

* Install Docker & Docker Compose (if missing)
* Start Spark Master & 1 Worker using Docker Compose

### 🔴 Stop Cluster

```bash
ansible-playbook -i inventory/hosts ansible/teardown.yml --ask-become-pass
```

This will:

* Stop and remove all containers from the Spark cluster
* Free up your local resources

---

### 🔴 Stop all Docker containers

```bash
docker stop $(docker ps -q)
```

---

## Running Docker Services Manually (Optional)

Since the `docker-compose.yml` file is located in the `docker/` directory, run the following from the project root:

```bash
# Stop all Spark-related services
docker compose -f docker/docker-compose.yml down

# Start Spark Master and Worker
docker compose -f docker/docker-compose.yml up -d
```

---

## Access Spark Web UI

* Spark Master UI : [http://localhost:8080](http://localhost:8080)
* Spark Worker UI : [http://localhost:8081](http://localhost:8081)

---

## Run a PySpark Job

Put your `.py` job files in the `spark-app/` folder. For example, `main.py`.

```bash
docker exec -it spark-master spark-submit --master spark://spark-master:7077 /opt/spark-app/main.py
```

> `/opt/spark-app/` is mounted from your local `spark-app/` directory.

---

## File Overview

### `inventory/hosts`

```ini
[local]
localhost ansible_connection=local
```

---

### `ansible/playbook.yml`

Installs Docker and runs Spark cluster.

---

### `ansible/teardown.yml`

Stops and removes Docker containers.

---

### `docker/docker-compose.yml`

Defines 1 master and 1 worker Spark services using Bitnami images.

---

### `spark-app/main.py`

A basic example PySpark job reading from a CSV.
