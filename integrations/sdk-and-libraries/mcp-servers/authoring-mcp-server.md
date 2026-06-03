---
description: >-
  Connect an MCP client to the DecisionRules Authoring Server to create, manage,
  test, and execute DecisionRules resources in an authenticated space.
---

# Authoring MCP Server

The **DecisionRules MCP Authoring Server** gives MCP-compatible clients authenticated access to DecisionRules authoring and management capabilities. It is designed for creating, updating, organizing, testing, and executing DecisionRules resources directly from AI tools and automation workflows.

Use this server when you want an AI assistant or MCP-compatible client to work with your DecisionRules space, including rules, rule flows, folders, tags, tests, and related management operations.

#### MCP Authoring Server Endpoint

```bash
https://api.decisionrules.io/mcp
```

{% hint style="warning" %}
The URL above is an MCP endpoint and cannot be opened in a browser.\
It is only for MCP-compatible clients.
{% endhint %}

#### Prerequisites

Before you begin, ensure that you have:

* An **MCP-compatible client** (e.g., IDE plugin, AI assistant, or other tools supporting MCP).
* Network access to the hosted DecisionRules API.
* A valid DecisionRules authentication token:
  * **Management API key** of the space, or
  * **OAuth bearer token** with the DecisionRules management scope

Your infrastructure must allow outbound access to the Authoring Server. If needed, review Network prerequisites.

#### Configuration

To connect your client, configure it with the hosted endpoint and an authorization header:

```json
{
  "mcpServers": {
    "decisionrulesAuthoring": {
      "url": "https://api.decisionrules.io/mcp",
      "headers": {
        "Authorization": "Bearer <YOUR_MANAGEMENT_API_KEY_OR_TOKEN>"
      }
    }
  }
}
```

**Explanation:**

* `"decisionrulesAuthoring"` – a descriptive name for the server connection.
* `"url"` – the hosted MCP Authoring Server endpoint.
* `"Authorization"` – bearer authentication used to access your DecisionRules space.

Once configured, your client can use DecisionRules authoring tools directly against the authenticated space.

#### What the server provides

Through this server, MCP clients can work with:

* **Rule management** – create, retrieve, update, delete, lock, publish, and version rules.
* **Rule flow management** – import, export, update, and manage rule flows.
* **Folder management** – create, rename, move, export, import, and delete folder trees.
* **Tag management** – add or remove tags from rules and rule versions.
* **Test management** – create, update, move, delete, and list test suites and tests.
* **Execution tools** – execute DecisionRules rules with supplied input data.
* **AI-assisted authoring** – generate rule proposals such as decision tables, scripting rules, or lookup tables.
* **Space utilities** – list space items, inspect statistics, and work with authenticated space metadata.

This makes the Authoring Server suitable for AI-assisted rule lifecycle management.

#### Common use cases

After setup, your client can use the server to:

* create a new decision table from a natural-language description
* update an existing rule or create a new rule version
* publish or unpublish a specific rule version
* inspect dependencies before changing a rule
* find duplicate rows in decision tables
* organize rules into folders
* import or export folder structures and rule flows
* create and maintain rule test suites
* execute a rule against sample input
* generate draft DecisionRules resources with AI

#### Benefits

* **Authenticated authoring**: works directly with your DecisionRules space.
* **AI-assisted workflows**: lets AI clients create, update, and inspect rules through structured tools.
* **Lifecycle coverage**: supports rule creation, versioning, testing, publishing, locking, and deletion.
* **Space-aware operations**: all actions run in the authenticated DecisionRules space.
* **Automation-ready**: enables IDEs, agents, and workflow tools to manage DecisionRules resources programmatically.
* **Separation of responsibilities**: keeps authoring and management operations separate from content distribution services.

#### Security Notes

The Authoring Server can modify resources in your DecisionRules space. Treat its credentials the same way you treat Management API keys.

Recommended practices:

* Use a token with only the permissions required for your workflow.
* Store credentials securely in your MCP client or secret manager.
* Avoid sharing MCP configuration files containing live tokens.
* Review generated changes before applying destructive operations such as delete, overwrite, or import.

#### Next Steps

1. Add the Authoring Server endpoint to your MCP client.
2. Configure the `Authorization` header with a valid DecisionRules token.
3. Verify the client can reach `https://api.decisionrules.io/mcp`.
4. Start using DecisionRules authoring tools in your AI workflows.

✅ Your MCP client is now ready to author and manage DecisionRules resources.
