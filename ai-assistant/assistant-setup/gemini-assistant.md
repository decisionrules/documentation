---
description: >-
  Follow these steps to generate your own Google Service Account credentials
  needed for your Gemini integration.
---

# Gemini Assistant

## How to Generate Your Gemini Configuration

1. **Open Google Cloud Console**\
   Go to [Google Service Accounts](https://console.cloud.google.com/iam-admin/serviceaccounts).
2. **Select or Create a Project**\
   Choose your existing project or create a new one where you want to manage AI access.
3. **Create a Service Account** (in case you don't have one yet)
   * Click **"Create Service Account"**.
   * Enter a name (e.g., "Gemini AI Access").
   * Click **"Create and Continue"**.
4. **Assign Roles**
   * Grant the service account the **"Vertex AI User"** role (or any other appropriate role to access Vertex AI).
   * Click **"Done"**.
5. **Generate a JSON Key**
   * Open your Service Account.
   * Go to the **"Keys"** tab.
   * Click **"Add Key" → "Create New Key"**.
   * Select **"JSON"** and click **"Create"**.
   * Download and securely store the JSON file.

[Official Google Developer Guide](https://developers.google.com/workspace/guides/create-credentials) how to create access credentials.

#### 🧾 Example Gemini Configuration File

When uploading your AI configuration for Google Gemini, the file should look similar to this:

```json
{
  "type": "service_account",
  "project_id": "your-gcp-project-id",
  "private_key_id": "your-private-key-id",
  "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n",
  "client_email": "your-service-account@your-gcp-project-id.iam.gserviceaccount.com",
  "client_id": "123456789012345678901",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/your-service-account%40your-gcp-project-id.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com",
}
```

## Enable Vertex AI API

Before using Gemini models, ensure that **Vertex AI is enabled** in your Google Cloud project. Without this, you won't be able to access models, endpoints, or perform predictions. To enable it:

1. Go to the Vertex AI API page.
2. Select your project.
3. Click **"Enable"**.

This step is required only once per project and can take a few seconds to activate.

## Choosing the Right Region for Gemini

When uploading your Gemini configuration file in DecisionRules, you’ll find a “Region” field in the form. This lets you select the Google Cloud region where your Gemini model will run.

By default, the model runs in  `us-central1` , which is widely supported and suitable for most users. However, selecting a region closer to your users or aligned with your existing Google Cloud infrastructure can offer benefits like:

* Faster response times due to reduced latency
* Compliance with data residency requirements
* Better integration with other region-specific services

You do not need to include the location in your configuration JSON — the selected region in the form will override it.

To learn more, see Google’s [official list of supported regions](https://cloud.google.com/vertex-ai/generative-ai/docs/models/gemini/2-0-flash-lite).

## Where to Upload Your Gemini Configuration

Now that you’ve generated your Google Cloud Service Account JSON file, you can upload it directly in the DecisionRules app by navigating to **Organization → Settings**.

There, you’ll find a form where you can:

* Select your AI model (**Gemini**)
* Fill in your preferred region
* Upload your configuration file in JSON format

Once uploaded, our system will use **your credentials securely and exclusively** to connect to your Gemini model on Vertex AI, enabling your organization to use the AI Assistant in a fully self-managed way. This approach gives you **full control** over your AI usage while keeping the integration flexible, isolated, and secure.

{% hint style="info" %}
Your configuration file is stored **securely in our internal database**, accessible only to the backend of your own Docker-deployed DecisionRules instance. We never transmit your credentials elsewhere, and the data is only used to authenticate requests to the Vertex AI service on your behalf.
{% endhint %}

### ⚡ **Instant Connection Test**

After submitting, the form will automatically test the connection to Vertex AI. You’ll see right away whether the setup is successful and if the AI assistant is ready to use.

If there’s an issue, you’ll be notified instantly so you can adjust your configuration or permissions without guessing.

## 🔧 Which Gemini Model Version Do We Use?

When your configuration is connected, our system automatically uses the model version:

> **`gemini-2.0-flash-lite-001`**

We’ve carefully tested multiple Gemini versions — including the more advanced and higher-priced options — and found that this particular version consistently provides the best results for our use cases in the DecisionRules environment.

⚠️ **Note:** A more powerful or expensive model doesn’t always mean better outcomes. In our case, `gemini-2.0-flash-lite-001` offers the best balance of performance, speed, cost-efficiency, and quality when used for business rule processing and assistant workflows.
