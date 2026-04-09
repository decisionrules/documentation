---
description: >-
  Frontend container for accessing the DecisionRules application in Docker and
  On-Premise environments.
---

# DecisionRules Client

{% hint style="success" %}
Production Container
{% endhint %}

## Introduction

The DecisionRules Client is the frontend application of the platform. It provides the user interface for working with rules, spaces, settings, and other DecisionRules features in a web browser.

Use this container when you deploy DecisionRules in Docker, Kubernetes, or other On-Premise environments. It exists to give users access to the platform UI while connecting to the DecisionRules Server API in the background.

The client requires:

* a running DecisionRules Server instance
* a reachable API URL for that server
* enough resources for the selected container type

Available container types:

* **Standard** container runs as root and listens on port `80`
* **Rootless** container uses the `-rootless` tag and listens on port `4000`

## Setup

### Where to get it

You can download the latest production image from Docker Hub:

* [DecisionRules Client on Docker Hub](https://hub.docker.com/r/decisionrules/client)

### Before you start

Before you run the client, make sure you have:

* a running DecisionRules Server instance
* the correct API URL for your server
* enough resources for your workload

See also:

* [Environment Variables](../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md)
* [DecisionRules Server](server-app.md)

### Minimal Requirements

* 100MB memory

### Application info

* Default port: 80

### How to run it

You can run the container directly with `docker run` or through `docker compose`.

**Method 1: Run with `docker run`**

Pull the latest image:

```bash
docker pull decisionrules/client
```

Run the standard container:

```bash
docker run -d \
  -p 80:80 \
  -e API_URL=YOUR_API_URL \
  decisionrules/client
```

If you use the rootless variant, use the `-rootless` tag and port `4000`.

**Method 2: Run with `docker compose`**

Create a `docker-compose.yml` file:

```yaml
version: "1.0"

services:
  client:
    image: decisionrules/client
    environment:
      - "API_URL=YOUR_API_URL"
    ports:
      - "80:80"
```

Start it with:

```bash
docker compose up
```

#### What to check after startup

The client must be reachable from your browser and must be able to connect to the DecisionRules Server.

After startup, open the configured client URL in your browser and confirm that:

* the application loads correctly
* API requests point to the correct server
* users can sign in and access the environment

{% hint style="info" %}
The required `API_URL` value must point to a reachable DecisionRules Server endpoint.
{% endhint %}
