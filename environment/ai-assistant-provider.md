---
icon: user-robot
---

# AI assistant provider

Use **Environment → AI Provider** to define AI assistant configuration for an **environment**

{% hint style="info" %}
This feature is available only in the **Docker / On‑Premise** deployment, and if you are an Environment Manager.
{% endhint %}

If you need access, contact your administrator or our sales team.

### How It Works

* The configuration set on the **Environment level** applies to the entire environment
* It affects all AI Engine applications running in that environment
* It serves as a **fallback** if no higher-level configuration is defined

#### Configuration Priority

AI configuration is resolved in the following order:

1. **Organization level**
2. **Environment level**
3. **AI Engine application level**

This means:

* If **Organization-level** configuration exists, it overrides Environment settings
* If not, the **Environment-level** configuration is used
* If neither is defined, the system falls back to the **AI Engine application level**

### What You Can Configure

The Environment AI Provider configuration uses the same setup as the global configuration.

You will define:

* **Model**
* **Provider**
* **Credentials** (API Key / Endpoint / JSON / Location)

See full setup guide: [define-ai-provider.md](../ai-assistant/assistant-setup/define-ai-provider.md "mention")

### When to Use Environment-Level Configuration

Use Environment-level configuration when:

* You do not want to define configuration for every Organization

### Notes

* Environment configuration overrides AI Engine configuration
* Organization configuration overrides Environment configuration
* Credentials are stored securely and are not visible after saving
* You can test the connection before saving

***
