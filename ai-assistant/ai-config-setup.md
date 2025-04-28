---
description: >-
  Follow these steps to generate your own Google Service Account credentials
  needed for AI integration.
hidden: true
---

# AI Config Setup

**Currently, we only support Gemini, but more AI options will be available in the future.**

If you're using the **Docker version** of DecisionRules, you can set up and manage your AI configuration in **Organization → Settings**.

## How to Generate Your AI Config

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

## How to Set Up Your AI Config

Now that you have generated your credentials Google Cloud Service Account JSON file, go to **Organization → Settings** in our app, where you can upload your AI configuration. This will allow our system to securely connect to your Gemini model using your own credentials.&#x20;
