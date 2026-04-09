---
description: >-
  Connect an MCP client to the DecisionRules Distribution Server to access
  managed templates, functions, and learning resources.
---

# MCP Distribution Server Setup Guide

The **DecisionRules MCP Distribution Server** gives MCP-compatible clients access to managed DecisionRules content. It is designed for templates, reusable functions, and curated resource links.

Use this server when you want shared DecisionRules assets available directly in your AI tools or automation workflows.

### MCP Distribution Server Endpoint

```bash
https://distribution.decisionrules.io/mcp
```

{% hint style="warning" %}
The URL above is an MCP endpoint and cannot be opened in a browser.\
It is only for MCP-compatible clients.
{% endhint %}

### Prerequisites

Before you begin, ensure that you have:

* An **MCP-compatible client** (e.g., IDE plugin, AI assistant, or other tools supporting MCP).
* Network access to the hosted MCP Distribution Server.

Your infrastructure must allow outbound access to the Distribution Server. If needed, review [Network prerequisites](../other-deployment-options/docker-and-on-premise/prerequisites.md).

### Configuration

To connect your client, configure it with the hosted endpoint:

```json
{
  "mcpServers": {
    "decisionrulesDistribution": {
      "url": "https://distribution.decisionrules.io/mcp"
    }
  }
}
```

**Explanation:**

* `"decisionrulesDistribution"` – a descriptive name for the server connection.
* `"url"` – the hosted MCP Distribution Server endpoint.

Once configured, your client can access managed DecisionRules content directly.

### What the server provides

Through this server, MCP clients can work with:

* **Predefined templates** for faster rule creation
* **Reusable functions and components**
* **Links to documentation and Academy resources**
* **Structured content** for AI assistants and automation flows

This keeps shared assets centralized and consistent across environments.

### Common use cases

After setup, your client can use the server to:

* discover available templates
* retrieve reusable functions
* surface learning resources inside AI workflows
* keep managed content separate from runtime or documentation MCP servers

### Benefits

* **Centralized content delivery**: one place for managed DecisionRules assets.
* **Consistent usage**: shared templates and functions stay aligned.
* **Seamless integration**: works with MCP-compatible clients without local setup.
* **Clear separation**: keeps distribution content separate from documentation and runtime services.

### Next Steps

1. Add the Distribution Server endpoint to your MCP client.
2. Verify the client can reach `https://distribution.decisionrules.io/mcp`.
3. Start using shared templates, functions, and managed resources in your workflows.

✅ Your MCP client is now ready to use DecisionRules managed content.
