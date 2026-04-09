---
description: >-
  This section covers how to configure and manage AI models used by the AI
  Assistant in DecisionRules.
---

# Assistant Setup

DecisionRules AI Assistant supports different AI integration options depending on your deployment type.

## Cloud Version

In the **Cloud version**, AI integration is fully managed by DecisionRules.

* No additional setup is required
* The AI Assistant is available out of the box
* Configuration is maintained by our team for optimal performance and reliability

### About the Model and Limits

The assistant is powered by **Gemini for Business**. We are currently using the model `gemini-3-flash-preview`. The exact versions may change in the future.

{% hint style="success" %}
Your privacy is fully respected. **No user data is used to train any AI model**, and nothing is shared outside Decision Rules application. See more information about data governance [here](https://cloud.google.com/vertex-ai/generative-ai/docs/data-governance) and [here](https://cloud.google.com/gemini/docs/discover/data-governance).
{% endhint %}

Current usage limits for the assistant are defined by your **subscription plan**. If you are on a free trial, paid Lite or higher tier, you will have access to a limited number of AI generations each month.

## Docker (On-Premise) Version

{% hint style="info" %}
Make sure that you have set **`AI_ENGINE_URL`**  environment variable. More details: [#server-required](../../other-deployment-options/docker-and-on-premise/containers-environmental-variables.md#server-required "mention")
{% endhint %}

In the **Docker version**, you can connect your own AI provider with the required credentials.

Configuration can be defined on the following levels:

* **Organization level**
* **Environment level**
* **AI Engine application level**

### Configuration Resolution

These configuration levels are evaluated in the following order:

1. **Organization level**
2. **Environment level**
3. **AI Engine application level**

This works as a fallback mechanism:

* When an **Organization-level** configuration exists, it is used
* If not, DecisionRules checks the **Environment level**
* If that is also not configured, DecisionRules uses the **AI Engine application level**

### Next Steps

For more details, see the dedicated pages for each configuration level:

* **Organization Level:** [define-ai-provider.md](define-ai-provider.md "mention")
* **Environment Level:** [ai-assistant-provider.md](../../environment/ai-assistant-provider.md "mention")
* **AI Engine Application Level:** [decisionrules-ai-engine.md](../../decisionrules-applications/decisionrules-ai-engine.md "mention")
