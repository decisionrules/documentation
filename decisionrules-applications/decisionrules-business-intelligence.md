---
description: >-
  Analytics container for audit logs and reporting in Docker and On-Premise
  environments.
---

# DecisionRules Business Intelligence

{% hint style="success" %}
Production Container
{% endhint %}

## Introduction

The DecisionRules Business Intelligence application provides access to audit log data for reporting, analytics, and external BI integrations.

Use this container when you need to analyze DecisionRules activity, connect reporting tools, or expose audit data for dashboards. It exists to separate analytics workloads from the main application runtime while still integrating with the DecisionRules client and server.

{% hint style="info" %}
The Business Intelligence application is optional. It is not required for a standard DecisionRules deployment.
{% endhint %}

The Business Intelligence application requires:

* a MongoDB connection for BI data
* a compatible DecisionRules Client and Server deployment
* enough resources for analytics workloads

## Setup

### Where to get it

You can download the latest production image from Docker Hub:

* [DecisionRules Business Intelligence on Docker Hub](https://hub.docker.com/r/decisionrules/business-intelligence)

### Before you start

Install this container only if you need audit log analytics, BI integrations, or reporting features.

Before you run the container, make sure you have:

* a MongoDB URI for Business Intelligence
* a running DecisionRules Client
* a running DecisionRules Server
* enough memory for your expected BI workload

See also:

* [#business-intelligence](../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md#business-intelligence "mention")
* [client-app.md](client-app.md "mention")
* [server-app.md](server-app.md "mention")

### Minimal Requirements

* 700MB memory per worker thread

### Application info

* Default port: 8082

### How to run it

You can run the container directly with `docker run` or through `docker compose`.

**Method 1: Run with `docker run`**

Pull the latest image:

```bash
docker pull decisionrules/business-intelligence
```

Run the container:

```bash
docker run -d \
  -p 8082:8082 \
  -e BI_MONGO_DB_URI=YOUR_MONGO_URI \
  decisionrules/business-intelligence
```

**Method 2: Run with `docker compose`**

Create a `docker-compose.yml` file:

```yaml
version: "1.0"

services:
  business-intelligence:
    image: decisionrules/business-intelligence
    environment:
      - "BI_MONGO_DB_URI=YOUR_MONGO_URI"
    ports:
      - "8082:8082"
```

Start it with:

```bash
docker compose up
```

#### Integration with other containers

To make the Business Intelligence application work correctly with the rest of the platform:

* set `BI_API_URL=YOUR_URL` in the Client container
* if you use a different MongoDB cluster for Business Intelligence, set `BI_MONGO_DB_URI=YOUR_URI` in the Server container as well

#### What to check after startup

After startup, confirm that:

* the Business Intelligence container is running
* the configured MongoDB connection works
* the client can reach the BI API endpoint
* BI features load correctly in the application

{% hint style="info" %}
For the full list of supported environment variables, see [Environment Variables](../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md).
{% endhint %}
