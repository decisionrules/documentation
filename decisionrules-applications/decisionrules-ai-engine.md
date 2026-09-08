---
description: >-
  AI service for DecisionRules guidance, automation support, and specialized
  assistant workflows in Docker and On-Premise environments.
---

# DecisionRules AI Engine

{% hint style="success" %}
**Production Container**
{% endhint %}

### Introduction

DecisionRules AI Engine provides the AI-powered services used by DecisionRules AI Assistant and AI-assisted integrations. It accepts requests from DecisionRules Server, routes them to specialized agents, communicates with the configured AI provider, and returns streamed or complete responses.

Depending on the compatible App version, AI Engine supports capabilities such as:

* Documentation, Academy, navigation, and general assistance
* Decision Table, Scripting Rule, Lookup Table, and Decision Flow authoring
* Natural-language changes to Decision Tables, Scripting Rules, and Decision Flows
* Multi-rule process planning, generation, recovery, and import preparation
* Function-expression, test-input, test-suite, and rule-summary generation
* File attachments, space context, and suggested follow-up prompts
* AI-assisted Authoring MCP operations

AI Engine keeps model-specific processing separate from the main application runtime while integrating with DecisionRules Client, Server, and Distribution Server.

{% hint style="info" %}
AI Engine is optional. It is not required for a standard DecisionRules deployment without AI-assisted features.
{% endhint %}

### Requirements

AI Engine requires:

* A compatible DecisionRules Client and DecisionRules Server
* Access to [DecisionRules Distribution Server](decisionrules-distribution-server.md)
* Access to a supported AI provider
* Provider credentials configured at the organization, environment, application, or request level
* Enough CPU and memory for the expected workload

#### Minimal Requirements

* 700 MB memory

#### Version Compatibility

Use the AI Engine version that matches the deployed DecisionRules App version. **App version** means the compatible DecisionRules Client and Server version.

| AI Engine Version | Supported App Version(s)      |
| ----------------- | ----------------------------- |
| 1.3.0             | 1.26.2 ≤ App Version          |
| 1.2.0             | 1.26.1 ≤ App Version < 1.26.2 |
| 1.1.0             | 1.25.2 ≤ App Version < 1.26.1 |
| 1.0.0             | 1.24.2 ≤ App Version < 1.25.2 |

{% hint style="warning" %}
Decision Flow Architect, Process Architect, and their related Authoring MCP tools require AI Engine **1.3.0 or later** together with DecisionRules App **1.26.2 or later**.
{% endhint %}

### Setup

#### Where to Get It

Download the production image from [DecisionRules AI Engine on Docker Hub](https://hub.docker.com/r/decisionrules/ai-engine).

#### Application Information

* Default port: `8084`
* Health endpoint: `/health-check`

#### Before You Start

Make sure that:

* DecisionRules Client and Server use a compatible App version
* DecisionRules Server can reach AI Engine through `AI_ENGINE_URL`
* AI Engine can reach DecisionRules Distribution Server
* AI Engine can reach the selected AI provider
* Valid provider credentials are configured

See also:

* [Assistant Setup](../ai-assistant/assistant-setup/)
* [Environment Variables](../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md#ai-engine)
* [DecisionRules Distribution Server](decisionrules-distribution-server.md)
* [DecisionRules Client](client-app.md)
* [DecisionRules Server](server-app.md)

### Run the Container

You can run AI Engine directly with Docker or through Docker Compose.

#### Run with Docker

Pull the image:

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

If every request supplies its own AI configuration, the default provider environment variables are optional.

#### Run with Docker Compose

Create a `docker-compose.yml` file:

```yaml
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

Start the service:

```bash
docker compose up -d
```

#### Verify the Deployment

After startup, confirm that:

* The AI Engine container remains healthy
* `GET /health-check` returns a successful response
* AI Engine can reach the configured provider
* AI Engine can reach DecisionRules Distribution Server
* DecisionRules Client and Server can complete an AI Assistant request

For a 1.3.0 deployment, also perform a smoke test that creates a Decision Flow proposal and a Process Architect plan without importing them.
