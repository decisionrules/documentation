---
description: >-
  To enable offline licensing for your server, follow the steps outlined below.
  This documentation explains how to configure and manage offline licenses,
  including preflight mode and generating license
icon: signal-bars-slash
---

# Offline License

{% hint style="info" %}
**This functionality is available from application version 1.19.3**
{% endhint %}

## Overview

Offline licensing allows your server to operate without an internet connection. To configure the offline license, you need to set specific environment variables and follow a predefined process to generate and apply the license file.

***

## Configuration

### Generating License Request File

If you already have a functional DecisionRules instance running, you can skip **Step 1** (Set Required Environment Variables) and **Step 2** (Generate a License Request File).&#x20;

You can generate the **License Request File** directly via a URL in your browser. Simply enter the following URL:

```
https://{API_URL}/offline-license/license-request

Where {API_URL} is domain of your running DecisionRules server instance.

For example:
https://api.decisionrules.io/offline-license/license-request
```

This will trigger the generation and download of the License Request File without requiring further configuration.

If you are setting up a new DecisionRules instance, follow the steps below.

#### Step 1: Set Required Environment Variables

1.  **Enable Offline License Mode**

    * Set the `OFFLINE_LICENSE` environment variable to `true`.

    ```bash
    OFFLINE_LICENSE=true
    ```
2.  **Provide Your License Key**

    * Set the `LICENSE_KEY` environment variable with the license key provided by DecisionRules.

    ```bash
    LICENSE_KEY=your_license_key_here
    ```
3.  **Optional: License File**

    * If you already have your Licensse file, set it to the env variable.

    ```bash
    LICENSE_FILE=your_license_file // as single line string
    LICENSE_FILE_PATH=your_license_file // as path to your license file
    ```

***

### Preflight Mode and License Request

If the application starts in preflight mode, it means the `LICENSE_FILE` environment variable is either missing or points to an invalid license file. The specific reason for preflight mode can be found in the **server application logs**.

#### Step 2: Generate a License Request File

1. Open client application and there should be **License Request Page**.
2. Download the **License Request File**. This file will contain the necessary information for generating the offline license file.

***

### Step 3: Send License Request File

Send the downloaded license request file to [**support@decisionrules.io**](mailto:support@decisionrules.io). Ensure to include any additional context or requirements in the email.

***

### Applying the Generated License

After receiving your license request, the DecisionRules team will generate the license file and send it back to you.

#### Step 4: Apply the License File

**There are 2 options:**

a) Set License file as string into environment variable.

1. Set the `LICENSE_FILE` environment variable

<pre class="language-bash"><code class="lang-bash"><strong>LICENSE_FILE=eyJrZXkiOiJvbDFkYm4wc0dGdE5aNndram1pckI1Q2duM.....
</strong></code></pre>

2. Restart your server to apply the license.

b) Set License file to your server and provide path

1. Save the provided license file to an accessible location on your server.
2.  Set the `LICENSE_FILE_PATH` environment variable to point to the license file's location.

    <pre class="language-bash"><code class="lang-bash"><strong>LICENSE_FILE=/path/to/generated/license/file.lic
    </strong></code></pre>
3. Restart your server to apply the license.

***

### Example Environment Variable Configuration

Below is an example `.env` file configuration for enabling offline licensing:

```bash
OFFLINE_LICENSE=true
LICENSE_KEY=abc123xyz789
LICENSE_FILE=eyJrZXkiOiJvbDFkYm4wc0dGdE5aNndram1pckI1Q2duM.....
```

***

## Troubleshooting

* **Preflight Mode Activated**: If the server starts in preflight mode, check the **server application logs** for detailed reasons, such as:
  * Missing `LICENSE_FILE` environment variable.
  * Invalid or corrupted license file.
  * License key mismatch.
* **Invalid License File**: If the license file is rejected, contact [**support@decisionrules.io**](mailto:support@decisionrules.io) for assistance.

***

By following these steps, you can successfully configure and manage offline licensing for your server. For additional support, contact our team at [**support@decisionrules.io**](mailto:support@decisionrules.io).
