---
description: >-
  Follow these steps to generate your own Google Service Account credentials
  needed for your Google Vertex integration.
---

# Google Vertex Credentials JSON

## Google Vertex Setup Guide

### How to Generate Your Gemini Configuration

#### 1. Open Google Cloud Console

Go to **Google Cloud Console** and open **Service Accounts**.

#### 2. Select or Create a Project

Choose an existing Google Cloud project or create a new one where you want to manage AI access.

#### 3. Create a Service Account

If you do not already have one:

* Click **Create Service Account**
* Enter a name, for example `Gemini AI Access`
* Click **Create and Continue**

#### 4. Assign Roles

Grant the service account the **Vertex AI User** role, or another role with sufficient access to Vertex AI.

Then click **Done**.

#### 5. Generate a JSON Key

* Open the created service account
* Go to the **Keys** tab
* Click **Add Key** → **Create New Key**
* Select **JSON**
* Click **Create**

Download the JSON file and store it securely.

### Example Credentials JSON

When configuring **Google Vertex**, the credentials JSON should look similar to this:

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
  "universe_domain": "googleapis.com"
}
```
