---
description: >-
  Configure the default AI provider, model, credentials, and provider-specific
  options for the DecisionRules AI Engine container. ---
---

# AI Engine providers and models

In Docker and on-premise deployments, the default AI provider and model can be configured directly through environment variables on the **DecisionRules AI Engine container**.

This configuration provides a fallback AI configuration. If a request already contains an organization-level provider configuration, the request configuration takes precedence.

Only one fallback provider and model combination can be configured for each AI Engine container.

### Requirements

The AI Engine is a separately versioned container. The DecisionRules Client and Server version does not determine the AI Engine version.

Configure the `AIA_*` variables on the **AI Engine container**, not on the Client or Server container.

### Environment variables

[#environment-variables](ai-engine-providers-and-models.md#environment-variables "mention")

### Supported providers and families

Supported `AIA_PROVIDER` values:

* `openai`
* `anthropic`
* `google`
* `google-vertex`
* `azure`
* `amazon-bedrock`
* `litellm`

Supported `AIA_FAMILY` values:

* `openai`
* `anthropic`
* `google`
* `amazon`
* `qwen`

Use the following provider and family combinations:

| `AIA_PROVIDER`   | Supported `AIA_FAMILY`                            | Credential format               | Required additional settings                  |
| ---------------- | ------------------------------------------------- | ------------------------------- | --------------------------------------------- |
| `openai`         | `openai`                                          | OpenAI API key                  | None                                          |
| `anthropic`      | `anthropic`                                       | Anthropic API key               | None                                          |
| `google`         | `google`                                          | Google AI API key               | None                                          |
| `google-vertex`  | `google`, `anthropic`                             | Google service account JSON     | `project` when not present in the credentials |
| `azure`          | `openai`, `anthropic`                             | JSON containing `api_key`       | `endpoint` or `azure_endpoint`                |
| `amazon-bedrock` | `amazon`, `anthropic`, `google`, `openai`, `qwen` | Amazon Bedrock API key          | None                                          |
| `litellm`        | `openai`                                          | API key for the target endpoint | `api_base`                                    |

The selected model must be available through the selected provider. Model capabilities can differ even within the same family.

### Additional configuration options

`AIA_ADDITIONAL_DATA_JSON` must contain a valid JSON object.

| Option                   | Provider         | Type    | Default                      | Description                                                                                                                          |
| ------------------------ | ---------------- | ------- | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `project`                | `google-vertex`  | string  | Service account `project_id` | Google Cloud project containing the model.                                                                                           |
| `location`               | `google-vertex`  | string  | `global`                     | Google Cloud location used by Vertex AI.                                                                                             |
| `endpoint`               | `azure`          | string  | —                            | Azure or Microsoft Foundry model endpoint.                                                                                           |
| `azure_endpoint`         | `azure`          | string  | —                            | Alias for `endpoint`.                                                                                                                |
| `region`                 | `amazon-bedrock` | string  | `global`                     | AWS region used for Bedrock.                                                                                                         |
| `api_base`               | `litellm`        | string  | —                            | Base URL of the OpenAI-compatible endpoint.                                                                                          |
| `merge_system_prompt`    | `litellm`        | boolean | `false`                      | Combines system messages for models that accept only one system message.                                                             |
| `structured_output_mode` | `litellm`        | string  | `tool`                       | Structured output mechanism. Supported values are `tool`, `native`, and `prompted`.                                                  |
| `fileAttachmentsEnabled` | All providers    | boolean | `false`                      | Advertises file attachment availability to the DecisionRules Client. The selected model must still support the required input types. |

#### Structured output modes

The `structured_output_mode` setting supports:

* `tool`: Uses tool calling to obtain structured output. This is the default.
* `native`: Uses the provider's native structured-output or JSON Schema capability.
* `prompted`: Requests structured output through the prompt. Use this as a compatibility fallback when tool-based or native structured output is unavailable.

The `merge_system_prompt` and `structured_output_mode` options configure the OpenAI model profile internally.

These options apply only to the current `litellm` OpenAI-compatible adapter.

### Provider examples

#### OpenAI

```yaml
ai-engine:
  image: decisionrules/ai-engine
  environment:
    AIA_PROVIDER: "openai"
    AIA_FAMILY: "openai"
    AIA_MODEL: "<OPENAI_MODEL_ID>"
    AIA_SECRET: "<OPENAI_API_KEY>"
```

#### Anthropic

```yaml
ai-engine:
  image: decisionrules/ai-engine
  environment:
    AIA_PROVIDER: "anthropic"
    AIA_FAMILY: "anthropic"
    AIA_MODEL: "<ANTHROPIC_MODEL_ID>"
    AIA_SECRET: "<ANTHROPIC_API_KEY>"
```

#### Google AI

Use this variant for models accessed using a Google AI API key.

```yaml
ai-engine:
  image: decisionrules/ai-engine
  environment:
    AIA_PROVIDER: "google"
    AIA_FAMILY: "google"
    AIA_MODEL: "<GOOGLE_MODEL_ID>"
    AIA_SECRET: "<GOOGLE_API_KEY>"
```

#### Google Vertex AI

`AIA_SECRET` must contain the complete Google service account credentials as a JSON object serialized into an environment variable.

```yaml
ai-engine:
  image: decisionrules/ai-engine
  environment:
    AIA_PROVIDER: "google-vertex"
    AIA_FAMILY: "google"
    AIA_MODEL: "<VERTEX_MODEL_ID>"
    AIA_SECRET: '<GOOGLE_SERVICE_ACCOUNT_JSON>'
    AIA_ADDITIONAL_DATA_JSON: >-
      {"project":"<GOOGLE_PROJECT_ID>","location":"global"}
```

To use an Anthropic model hosted on Vertex AI, set:

```yaml
AIA_FAMILY: "anthropic"
```

When `project` is omitted, the AI Engine uses `project_id` from the service account JSON. When `location` is omitted, it defaults to `global`.

#### Azure and Microsoft Foundry

For Azure, `AIA_SECRET` must be a JSON object containing `api_key` or `apiKey`.

```yaml
ai-engine:
  image: decisionrules/ai-engine
  environment:
    AIA_PROVIDER: "azure"
    AIA_FAMILY: "openai"
    AIA_MODEL: "<AZURE_DEPLOYMENT_OR_MODEL_ID>"
    AIA_SECRET: >-
      {"api_key":"<AZURE_API_KEY>"}
    AIA_ADDITIONAL_DATA_JSON: >-
      {"endpoint":"<AZURE_OR_FOUNDRY_ENDPOINT>"}
```

To use an Anthropic model exposed through Microsoft Foundry, set:

```yaml
AIA_FAMILY: "anthropic"
```

The endpoint can be supplied using either `endpoint` or `azure_endpoint`.

#### Amazon Bedrock

```yaml
ai-engine:
  image: decisionrules/ai-engine
  environment:
    AIA_PROVIDER: "amazon-bedrock"
    AIA_FAMILY: "anthropic"
    AIA_MODEL: "<BEDROCK_MODEL_ID>"
    AIA_SECRET: "<BEDROCK_API_KEY>"
    AIA_ADDITIONAL_DATA_JSON: >-
      {"region":"eu-central-1"}
```

For model families other than `openai` and `qwen`, the AI Engine adds the geographic prefix derived from the configured region to the model ID.

For `openai` and `qwen`, the configured model ID is used unchanged.

#### OpenAI-compatible endpoints

In AI Engine, OpenAI-compatible endpoints use:

```yaml
AIA_PROVIDER: "litellm"
AIA_FAMILY: "openai"
```

The name `litellm` selects an adapter included in the DecisionRules AI Engine. It does **not** require you to install, deploy, or configure a separate LiteLLM service.

```yaml
ai-engine:
  image: decisionrules/ai-engine
  environment:
    AIA_PROVIDER: "litellm"
    AIA_FAMILY: "openai"
    AIA_MODEL: "<PROVIDER_MODEL_ID>"
    AIA_SECRET: "<PROVIDER_API_KEY>"
    AIA_ADDITIONAL_DATA_JSON: >-
      {"api_base":"<OPENAI_COMPATIBLE_BASE_URL>","merge_system_prompt":true,"structured_output_mode":"tool"}
```

Example endpoints:

| Service                  | `api_base`                                   |
| ------------------------ | -------------------------------------------- |
| Scaleway Generative APIs | `https://api.scaleway.ai/v1`                 |
| OpenRouter               | `https://openrouter.ai/api/v1`               |
| LiteLLM Proxy            | `http://litellm:4000/v1`                     |
| Other compatible service | Provider-specific OpenAI-compatible base URL |

Before using a custom model in production, verify that it supports the capabilities required by the enabled AI Assistant features, particularly:

* function and tool calling,
* structured outputs,
* sufficient context and output-token limits,
* streaming, when required.

OpenAI API compatibility alone does not guarantee that every model supports the complete DecisionRules AI Assistant workflow.
