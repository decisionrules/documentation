---
description: >-
  AI service for DecisionRules guidance, automation support, and specialized
  assistant workflows in Docker and On-Premise environments.
---

# DecisionRules AI Engine

{% hint style="success" %}
**Production Container**
{% endhint %}

## Introduction

The DecisionRules AI Engine application provides AI-powered support for DecisionRules users and integrations. It accepts requests, routes them to specialized AI services, and returns responses for tasks such as documentation help, rule summaries, decision table design support, function generation, input generation, and UI-related guidance.

Use this service when you want to add AI capabilities to your DecisionRules deployment or expose AI-based workflows to users and connected applications. It exists to keep AI-specific processing separate from the main application runtime while still integrating with the DecisionRules platform.

{% hint style="info" %}
The AI Engine application is optional. It is not required for a standard DecisionRules deployment.
{% endhint %}

The DecisionRules AI Engine application requires:

* access to a [decisionrules-distribution-server.md](decisionrules-distribution-server.md "mention")
* access to a supported AI provider
* enough CPU and memory for the expected AI workload

## Setup

### Where to get it

You can download the latest production image from Docker Hub:

* [DecisionRules AI Engine on Docker Hub](https://hub.docker.com/r/decisionrules/ai-engine)

### Before you start

Install this container only if you need AI-assisted features such as documentation support, rule summaries, decision table design assistance, function generation, input generation, or streamed AI responses.

Before you run the container, make sure you have:

* AI provider credentials configured in the environment or supplied in requests
* a running [client-app.md](client-app.md "mention") or [server-app.md](server-app.md "mention") that will call the AI Engine API

See also:

* &#x20;[#ai-engine](../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md#ai-engine "mention")
* [decisionrules-distribution-server.md](decisionrules-distribution-server.md "mention")
* [client-app.md](client-app.md "mention")
* [server-app.md](server-app.md "mention")

### Minimal Requirements

* 700MB memory

### Version compatibility

Ensure your AI Engine version matches the supported App version (DecisionRules Server + DecisionRules Client)

| AI Engine Version | Supported App Version(s) |
| ----------------- | ------------------------ |
| **1.0.0**         | ≥ 1.24.2                 |

### Application info

* Default port: 8084

### How to run it

You can run the container directly with `docker run` or through `docker compose`.

**Method 1: Run with `docker run`**

Pull the latest image:

```bash
docker pull decisionrules/ai-engine
```

Run the container:

```bash
docker run -d \
  -p 8084:8084 \
  -e AIA_PROVIDER=openai \
  -e AIA_FAMILY=openai \
  -e AIA_MODEL=gpt-4o-mini \
  -e AIA_SECRET=YOUR_PROVIDER_SECRET \
  decisionrules/ai-engine
```

If every request provides its own AI configuration, the default AI environment variables are optional.

**Method 2: Run with `docker compose`**

Create a `docker-compose.yml` file:

```yaml
version: "1.0"

services:
  ai-engine:
    image: decisionrules/ai-engine
    ports:
      - "8084:8084"
    environment:
      AIA_PROVIDER: openai
      AIA_FAMILY: openai
      AIA_MODEL: gpt-4o-mini
      AIA_SECRET: YOUR_PROVIDER_SECRET
```

Start it with:

```bash
docker compose up
```

#### What to check after startup

After startup, confirm that:

* the AI Engine container is running
* the /health-check endpoint returns a successful response
* the service can reach the configured AI provider
* the service can reach the required [decisionrules-distribution-server.md](decisionrules-distribution-server.md "mention")
* the [client-app.md](client-app.md "mention") or [server-app.md](server-app.md "mention") can successfully call the AI Engine API
