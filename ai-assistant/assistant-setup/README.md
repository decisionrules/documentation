---
description: >-
  This section covers how to configure and manage AI models used by the AI
  Assistant in DecisionRules.
---

# Assistant Setup

## Assistant Setup

DecisionRules AI Assistant supports managed Cloud operation and configurable self-hosted operation.

### Cloud Version

In the **Cloud version**, DecisionRules manages the AI integration.

* No additional AI Engine setup is required
* AI Assistant is available according to your subscription and Space Role
* DecisionRules maintains the provider configuration and compatible application versions

#### Model and Usage Limits

The managed Assistant is powered by **Gemini for Business** and currently uses `gemini-3.7-flash`. The exact model can change as the service is updated.

Usage limits are determined by the subscription plan. Free Trial, paid Lite, and higher plans include a plan-specific number of AI generations.

{% hint style="success" %}
User data sent for an AI request is used to generate that response and is not used to train the underlying AI model. For provider information, see [Vertex AI data governance](https://cloud.google.com/vertex-ai/generative-ai/docs/data-governance) and [Gemini data governance](https://cloud.google.com/gemini/docs/discover/data-governance).
{% endhint %}

### Docker and On-Premise Versions

Self-hosted deployments run DecisionRules AI Engine as a separate optional application and connect it to a supported AI provider.

{% hint style="info" %}
Set the **`AI_ENGINE_URL`** environment variable on DecisionRules Server. See [Environment Variables](../../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md#server-required).
{% endhint %}

#### Match the Application Versions

Use an AI Engine version compatible with the DecisionRules Client and Server version in the same deployment.

Decision Flow Architect, Process Architect, and the other AI authoring improvements introduced in this release require:

* DecisionRules Client and Server **1.26.2 or later**
* DecisionRules AI Engine **1.3.0 or later**

See the complete [AI Engine compatibility table](../../decisionrules-applications/decisionrules-ai-engine.md#version-compatibility).

#### Configure an AI Provider

Provider configuration can be defined at these levels:

* **Organization level**
* **Environment level**
* **AI Engine application level**

The first available configuration is used in this order:

1. Organization level
2. Environment level
3. AI Engine application level

This allows a shared configuration to be defined for an organization while still providing environment- and application-level fallbacks.

#### Next Steps

Use the page matching the configuration level you want to manage:

* **Organization:** [Define AI Provider](define-ai-provider.md)
* **Environment:** [AI Assistant Provider](../../environment/ai-assistant-provider.md)
* **AI Engine application:** [DecisionRules AI Engine](../../decisionrules-applications/decisionrules-ai-engine.md)

After setup, verify that the Client and Server can reach AI Engine and that AI Engine can reach the configured provider and DecisionRules Distribution Server.
