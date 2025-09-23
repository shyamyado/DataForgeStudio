# Monitoring Stack: Prometheus + Grafana + Node Exporter

A simple monitoring stack to collect **system metrics** (CPU, memory, disk, network) using **Prometheus** and visualize them with **Grafana**.

---

## Components

* **Prometheus** → scrapes metrics from Node Exporter & applications.
* **Node Exporter** → exposes system-level metrics (`/metrics`).
* **Grafana** → dashboards + visualization.
* *(Optional)* **Application Exporters** → instrumented apps exposing metrics.

---

## Getting Started

### 1. Clone the project

```bash
git clone <your-repo-url> monitoring-stack
cd monitoring-stack
```

### 2. Start the stack

```bash
docker-compose up -d
```

### 3. Access the services

* Prometheus → [http://localhost:9090](http://localhost:9090)
* Node Exporter → [http://localhost:9100/metrics](http://localhost:9100/metrics)
* Grafana → [http://localhost:3000](http://localhost:3000) (user: `admin`, pass: `admin`)

---

## Setting Up Grafana

1. Login to Grafana → `http://localhost:3000`.
2. Go to **Configuration → Data Sources → Add Data Source**.

   * Choose **Prometheus**.
   * URL: `http://prometheus:9090`.
   * Save & Test.
3. Import **Node Exporter Full Dashboard**:

   * Dashboards → Import.
   * Enter **Dashboard ID: 1860**.
   * Select Prometheus as data source.

---

## Project Structure

```
monitoring-stack/
├── docker-compose.yml
├── prometheus.yml
└── README.md
```

---

## 🛑 Stop the stack

```bash
docker-compose down
```

---

## 🔮 Next Steps

### 1. Add Application Metrics (Example: Python FastAPI)

You can expose app-level metrics by instrumenting your app:

#### Install Prometheus client

```bash
pip install prometheus-client
```

#### FastAPI Example

```python
from fastapi import FastAPI
from prometheus_client import Counter, generate_latest
from fastapi.responses import PlainTextResponse

app = FastAPI()

REQUEST_COUNT = Counter("app_requests_total", "Total requests")

@app.get("/")
def root():
    REQUEST_COUNT.inc()
    return {"msg": "Hello World"}

@app.get("/metrics")
def metrics():
    return PlainTextResponse(generate_latest())
```

#### prometheus.yml (add job)

```yaml
scrape_configs:
  - job_name: 'node'
    static_configs:
      - targets: ['node-exporter:9100']

  - job_name: 'fastapi-app'
    static_configs:
      - targets: ['host.docker.internal:8000']  # if app runs locally
```

Now Prometheus scrapes both **system metrics** and **application metrics**, and you can build **custom dashboards in Grafana** for your app.

---

### 2. Add Alerting

* Integrate **Alertmanager** for Slack/email alerts.

### 3. Extend Dashboards

* Add DB dashboards (Postgres, Redis, Kafka, etc.).

---
