---
description: >-
  Backend container for running DecisionRules in Docker and On-Premise
  environments.
---

# DecisionRules Server

{% hint style="success" %}
Production Container
{% endhint %}

## Introduction

The DecisionRules Server is the main backend application of the platform. It powers rule evaluation, management APIs, background processing, licensing, and communication with the client application.

Use this container when you deploy DecisionRules in Docker, Kubernetes, or other On-Premise environments. It exists to provide the core runtime and API layer behind the DecisionRules UI and integrations.

The server requires these supporting services:

* [MongoDB](https://www.mongodb.com/) for persistent data storage
* [Redis Cache](https://redis.io/) for caching and internal processing
* a valid license key or offline license
* network access to required DecisionRules services when using online licensing

## Setup

### Where to get it

You can download the latest production image from Docker Hub:

* [DecisionRules Server on Docker Hub](https://hub.docker.com/r/decisionrules/server)

### Before you start

Before you run the server, make sure you have:

* a running MongoDB instance
* a running Redis instance
* a valid license key
* enough resources for your workload

See also:

* [#server-required](../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md#server-required "mention")
* [prerequisites.md](../other-deployment-options/docker-and-on-premise/prerequisites.md "mention")
* [offline-license.md](../other-deployment-options/docker-and-on-premise/offline-license.md "mention")

### Minimal Requirements

#### Recommended configuration

From server version 1.27.0, use the following starting configuration per replica:

| Workload                 | CPU    | Memory | `WORKERS_NUMBER` |
| ------------------------ | ------ | ------ | ---------------- |
| V1 only                  | 1 vCPU | 2 GiB  | `1`              |
| V2 (Aero) or mixed V1/V2 | 4 vCPU | 4 GiB  | `1`              |

These resources cover the entire server container, including Node.js and Aero. Allocate resources for MongoDB, Redis and other services separately.

#### Scaling

* **V1:** Use smaller replicas and scale horizontally as traffic grows.
* **Aero or mixed traffic:** Prefer more CPUs per replica. Aero uses multiple CPUs within one process and shares its cache across concurrent solves.
* Keep at least **two server replicas** for availability, with enough capacity to handle traffic during a restart or replica failure.

`WORKERS_NUMBER` controls Node.js processes. Aero can use multiple CPUs with `WORKERS_NUMBER=1`; increase Node workers when the Node.js workload needs more capacity. CPU allocations and limits must apply to the server container, not just its host.

#### Resource reserve

At peak load, keep approximately **30% of memory free** and target **60–70% CPU utilization**. Include warm caches, concurrent requests, jobs and audit processing in the memory budget. Increase capacity when this reserve is consistently consumed.

For Kubernetes, size the server for Aero or mixed traffic with `4000m` CPU / `4Gi` memory for both requests and limits and autoscaling between 2 and 5 replicas. For the classic Gaia (V1) solver only, use `1000m` CPU / `1Gi` memory requests, `2000m` CPU / `2Gi` memory limits and autoscaling between 2 and 10 replicas. The DecisionRules Helm charts select these profiles with their `solver` setting. Use equivalent allocations in Docker and ECS on EC2. AWS Fargate and the Azure Container Apps Consumption profile only offer fixed CPU and memory combinations, so give the Aero server 4 vCPU and 8 GiB there: Fargate requires at least 8 GB of memory for 4 vCPU, and Container Apps allocates 2 GiB of memory per vCPU.

See [Environment Variables](../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md) for worker and cache settings.

### Application info

* Default port: 8080
* Port for preflight: 8081

### How to run it

You can run the container directly with `docker run` or through `docker compose`.

**Method 1: Run with `docker run`**

Pull the latest image:

```bash
docker pull decisionrules/server
```

Run the container:

```bash
docker run -d \
  -p 8080:8080 \
  -p 8081:8081 \
  -e WORKERS_NUMBER=1 \
  -e REDIS_URL=YOUR_REDIS_URL \
  -e MONGO_DB_URI=YOUR_MONGODB_URL \
  -e CLIENT_URL=http://localhost:80/#/ \
  -e LICENSE_KEY=YOUR_LICENSE_KEY \
  -v license:/assets/lic/ \
  decisionrules/server
```

**Method 2: Run with `docker compose`**

Create a `docker-compose.yml` file:

```yaml
version: "1.0"

services:
  server:
    image: decisionrules/server
    environment:
      - "REDIS_URL=YOUR_REDIS_URL"
      - "MONGO_DB_URI=YOUR_MONGO_URI"
      - "CLIENT_URL=YOUR_CLIENT_URL"
      - "LICENSE_KEY=YOUR_LICENSE_KEY"
    ports:
      - "8080:8080"
      - "8081:8081"
    volumes:
      - license:/assets/lic/:rw

volumes:
  license:
    driver: local
```

Start it with:

```bash
docker compose up
```

#### What to check after startup

The server must be reachable by the client application and other services that depend on it.

To verify that the server is running, open:

```
SERVER_URL/health-check
```

You should receive an HTTP `200 OK` response.

{% hint style="info" %}
Some environment variables are optional. For the full list, see [Environment Variables](../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md).
{% endhint %}
