# Kafka Module

This folder contains a **standalone Kafka + Zookeeper setup** using Docker Compose.
It is designed to be isolated from other services (Airflow, TimescaleDB, Monitoring), but can be connected later if needed.

---

## Getting Started

### 1. Start Services

```bash
docker compose up -d
```

### 2. Stop Services

```bash
docker compose down
```

### 3. Check Running Containers

```bash
docker ps
```

---

## Services

* **Zookeeper** → `localhost:2181`
* **Kafka Broker** → `localhost:9092`
* **Kafka UI** → `http://localhost:18080` (browse topics, messages, consumer groups)

Data is persisted in a Docker volume: `kafka-data`.

---

## Quick Test

1. **Create a topic**

```bash
docker exec -it kafka-broker kafka-topics \
  --create --topic test \
  --bootstrap-server localhost:9092 \
  --partitions 3 --replication-factor 1
```

2. **Produce messages**

```bash
docker exec -it kafka-broker kafka-console-producer \
  --topic test --bootstrap-server localhost:9092
```

Type a few messages, for example:

```
hello
world
kafka!
```

3. **Consume messages**

```bash
docker exec -it kafka-broker kafka-console-consumer \
  --topic test --from-beginning --bootstrap-server localhost:9092
```

4. **View messages in Kafka UI**

* Open browser: `http://localhost:18080`
* Browse topics, messages, partitions, and consumer groups interactively.

---

## Notes

* This setup is for **local development & testing**.
* In production, use multiple brokers and replication > 1.
* Other project modules (Airflow, Spark, TimescaleDB) can connect via `localhost:9092`.
* Kafka UI is optional but useful for **visual monitoring and debugging**.

