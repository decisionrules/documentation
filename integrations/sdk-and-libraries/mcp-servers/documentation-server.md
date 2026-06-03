---
hidden: true
---

# Documentation Server

The **DecisionRules MCP Documentation Server** allows you to access our full documentation directly from MCP-compatible clients and tools. It is specifically designed for searching guides, API references, code examples, and feature explanations—separately from any other MCP servers you may use.

With this server, you can use the **`searchDocumentation`** tool to quickly retrieve relevant information and jump directly to the appropriate documentation pages.

### MCP Documentation Server Endpoint

```bash
https://docs.decisionrules.io/doc/~gitbook/mcp
```

{% hint style="warning" %}
The URL above is an MCP endpoint and cannot be opened in a browser.\
It is only for MCP-compatible clients.
{% endhint %}

### Prerequisites

Before you begin, ensure that you have:

* An **MCP-compatible client** (e.g., IDE plugin, AI assistant, or other tools supporting MCP).
* Network access to the hosted MCP Documentation Server.

### Configuration

To connect your client to the MCP Documentation Server, configure it using the following snippet:

```json
{
  "mcpServers": {
    "decisionrulesDocs": {
      "url": "https://docs.decisionrules.io/doc/~gitbook/mcp"
    }
  }
}
```

**Explanation:**

* `"decisionrulesDocs"` – a descriptive name for the documentation server connection.
* `"url"` – the hosted MCP Documentation Server endpoint.

Once configured, your client will be able to query DecisionRules documentation directly.

### Using `searchDocumentation`

After setup, you can use the **`searchDocumentation`** tool to find information quickly:

* _“How do I create a decision table?”_
* _“Show me the Decision API reference.”_
* _“Where are the Node.js SDK examples?”_

The server returns **contextual snippets** and **direct links** to the full documentation pages, so you can access what you need without manual browsing.

### Benefits

* **Direct access to official documentation** – always up-to-date and accurate.
* **Faster research** – instantly locate guides, API references, and examples.
* **Seamless integration** – works with any MCP-compatible client without local installations.
* **Clear separation from runtime servers** – this endpoint is documentation-only, keeping your tools organized.

### Next Steps

1. Connect your preferred MCP-compatible client to the documentation server:\
   👉 [https://docs.decisionrules.io/doc/\~gitbook/mcp](https://docs.decisionrules.io/doc/~gitbook/mcp)
2. Start querying documentation using `searchDocumentation`.
3. Explore additional features as the MCP Documentation Server evolves.

✅ You’re now ready to make the most of DecisionRules documentation directly within your workflow.
