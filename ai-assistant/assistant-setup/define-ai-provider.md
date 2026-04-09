# Define AI Provider

## AI Provider Settings

AI Provider Settings allow you to configure which **model**, **provider**, and **credentials** the DecisionRules AI Assistant will use.

In the configuration form, the user first selects a **model**, then a compatible **provider**, and finally fills in the required provider-specific credentials such as an **API key**, **endpoint**, **credentials JSON**, or **location**.

### Supported Providers

DecisionRules currently supports these providers:

* **Google**
* **Google Vertex**
* **Anthropic**
* **OpenAI**
* **Microsoft Foundry**

### How Configuration Works

The setup always follows the same flow:

1. Select a **model**
2. Select a compatible **provider**
3. Fill in the required provider-specific credentials
4. Test the connection
5. Save the configuration

The exact fields in the form depend on the selected provider.

## Provider Setup

### Google

For the **Google** provider, the user only needs to provide:

* **API Key**

### Anthropic

For the **Anthropic** provider, the user only needs to provide:

* **API Key**

### OpenAI

For the **OpenAI** provider, the user only needs to provide:

* **API Key**

### Microsoft Foundry

For **Microsoft Foundry**, the user must provide:

* **Endpoint**
* **API Key**

#### Where to find the Endpoint

The endpoint is available in Microsoft Foundry in:

**Build → Models → Select model → Code → Endpoint**

#### Where to find the API Key

The API key is available in:

**Home → API Key**

### Google Vertex

For **Google Vertex**, the user must provide:

* **Credentials JSON**
* **Location ID**

This setup is intended for organizations that want to use Gemini through **Vertex AI** with their own Google Cloud project and service account.

How to get [google-vertex-credentials-json.md](google-vertex-credentials-json.md "mention")
