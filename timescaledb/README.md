# TimescaleDB Docker Setup

Run TimescaleDB in Docker and connect using your local pgAdmin or any PostgreSQL client.

---

## Setup

1. **Start TimescaleDB container**

```bash
docker-compose up -d
````

2. **Connect using local pgAdmin**

* **Host:** `localhost`
* **Port:** `55432`
* **Database:** `tsdb`
* **User:** `tsuser`
* **Password:** `tspassword`

3. **Enable TimescaleDB extension**

```sql
CREATE EXTENSION IF NOT EXISTS timescaledb;
```

---

## Stop Container

```bash
docker-compose down
```

