---
description: >-
  Connect an MCP client to the DecisionRules Authoring Server to create, manage,
  test, and execute DecisionRules resources in an authenticated space.
---

# Authoring MCP Server

The **DecisionRules MCP Authoring Server** gives MCP-compatible clients authenticated access to DecisionRules authoring and management capabilities. It is designed for creating, updating, organizing, testing, and executing DecisionRules resources directly from AI tools and automation workflows.

Use this server when you want an AI assistant or MCP-compatible client to work with your DecisionRules space, including rules, rule flows, folders, tags, tests, and related management operations.

{% hint style="danger" %}
**Full authoring access.** Grant **Connect MCP Server** only to trusted users. During OAuth approval, the connected client receives full Management API access to the selected space. Its later actions are not limited by the connecting user's granular rule permissions.
{% endhint %}

## What can it do?

* Read and list rules, folders, tags, tests, and test suites.
* Create and update rules, versions, states, and folder structures.
* Import, export, move, and organize resources.
* Generate a Decision Table, Scripting Rule, or Lookup Table from a natural-language assignment.
* Solve a rule when the space has a Solver API key.

## Connect to the Authoring MCP Server

### Prerequisites

Before connecting, make sure that:

* Your MCP client supports remote HTTP MCP servers.
* Your DecisionRules subscription includes Management API and MCP authoring.
* You have access to the space you want to connect.
* Your role has the **Connect MCP Server** permission.
* The space has a Management API key, or your role has **Create API Key** permission so one can be created during approval.
* The space has a Solver API key if you want to use the `solve_rule` tool.

See Space API Keys and Space Access for key and permission management.

### Roles and connection permissions

The permission to connect an MCP client is separate from the permissions used to manage existing connections.

| Role or access model     | Default behavior                                                               |
| ------------------------ | ------------------------------------------------------------------------------ |
| Private-space Admin      | Can connect MCP clients, view active connections, and revoke them.             |
| Editor                   | Can connect an MCP client but cannot open the MCP Connections management page. |
| Reader                   | Cannot connect MCP clients or manage connections.                              |
| Organization/custom role | Permissions must be added explicitly through the space role or policy.         |

For organization spaces, being an organization owner or administrator does not automatically grant MCP connection management in every space. The assigned space role or policy must include:

* **Connect MCP Server** to authorize a client.
* **View MCP Connections** to open the connection list.
* **Delete MCP Connection** to revoke connections.

{% hint style="danger" %}
#### Grant **Connect MCP Server** only to trusted users

During approval, the MCP client receives full Management API access to the selected space. The client's later MCP operations are not limited by the connecting user's granular rule permissions.
{% endhint %}

### MCP server URL

Use the URL for your DecisionRules environment:

| Environment       | MCP server URL                        |
| ----------------- | ------------------------------------- |
| Standard cloud    | `https://api.decisionrules.io/mcp`    |
| EU regional cloud | `https://eu.api.decisionrules.io/mcp` |
| US regional cloud | `https://us.api.decisionrules.io/mcp` |
| AU regional cloud | `https://au.api.decisionrules.io/mcp` |
| Self-hosted       | `<YOUR_API_URL>/mcp`                  |

### Connect with OAuth

OAuth is the recommended option for interactive MCP clients.

You can connect through ChatGPT/Codex, Claude, MCP Inspector, or any other MCP client that supports remote HTTP servers and OAuth. The following example uses the ChatGPT/Codex app.

{% stepper %}
{% step %}
#### Add the server

Add a remote MCP server in your client and enter the MCP server URL for your environment.

<figure><img src="https://437457296-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MN4F4-qybg8XDATvios%2Fuploads%2FgkIRinfjCltWOVy43UIx%2FStep1MCP.png?alt=media&#x26;token=ffec4685-18a7-46cf-9998-475766a3442d" alt=""><figcaption></figcaption></figure>

<figure><img src="https://437457296-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MN4F4-qybg8XDATvios%2Fuploads%2Fz36SPYiGNQdl4m99DfBy%2FStep2MCP.png?alt=media&#x26;token=ee429301-2b6a-4c86-9ee7-369091516b28" alt=""><figcaption></figcaption></figure>

<figure><img src="https://437457296-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MN4F4-qybg8XDATvios%2Fuploads%2FwM597hPNPAZAw5jU3ulg%2FStep3.png?alt=media&#x26;token=8da24144-4671-4391-9cac-7fbb7dd08480" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
#### Sign in

After adding the server, click **Authenticate**.

<figure><img src="https://437457296-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MN4F4-qybg8XDATvios%2Fuploads%2FCG3uVTaNC1W0emYJklmG%2Fstep4.png?alt=media&#x26;token=ce97960d-b0fc-4af7-a71a-ea7a30ff6883" alt=""><figcaption></figcaption></figure>

The client opens DecisionRules in your browser. Sign in as usual if required.

<figure><img src="https://437457296-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MN4F4-qybg8XDATvios%2Fuploads%2FzBFdTfjZFskxw5AFxOny%2FStep5.png?alt=media&#x26;token=9923b266-46a8-4a43-bb9f-791ce4b695fd" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
#### Choose a space

Select the space that the client can access. One connection can access only this space.

<figure><img src="https://437457296-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MN4F4-qybg8XDATvios%2Fuploads%2FDh1Pbt27PXT1bUp3U7Nw%2FStep6MCP.png?alt=media&#x26;token=c50d4dc2-116b-4985-a9bf-f68dbf5b62be" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
#### Review and approve

Review the requested access, then click **Allow Access**. If the space has no Management API key, approval creates one when you have **Create API Key** permission.
{% endstep %}

{% step %}
#### Return to the client

After approval, you are redirected to a page confirming that the setup was successful. The MCP server is now available in your client. You may need to restart ChatGPT before the new MCP server appears.

The connection also appears under **Space → MCP Connections** for users who have **View MCP Connections** permission.

<figure><img src="https://437457296-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MN4F4-qybg8XDATvios%2Fuploads%2Fyx3Z16Qv9gBhDcgWwwuy%2FStep7MCP.png?alt=media&#x26;token=aba6fdba-ca9b-4389-bf75-2369c5b48a91" alt=""><figcaption></figcaption></figure>
{% endstep %}
{% endstepper %}

### Connect with a Management API key

Use this option for clients that cannot complete OAuth or for controlled service integrations.

1. Open **Space → API Keys**.
2. Create or copy a **Management API** key.
3. Configure the MCP URL and send the key as a Bearer token.

For clients that accept an MCP JSON configuration, use the equivalent of:

```json
{
  "mcpServers": {
    "decisionrules": {
      "url": "https://api.decisionrules.io/mcp",
      "headers": {
        "Authorization": "Bearer <MANAGEMENT_API_KEY>"
      }
    }
  }
}
```

{% hint style="warning" %}
Treat a Management API key as a secret. It provides full Management API access to its space. A connection using a static key is not listed under **Space → MCP Connections**.
{% endhint %}

### Troubleshooting

| Problem                                | Resolution                                                             |
| -------------------------------------- | ---------------------------------------------------------------------- |
| Approval is disabled                   | Ask for the **Connect MCP Server** permission in the selected space.   |
| A Management API key cannot be created | Create the key first, or ask for **Create API Key** permission.        |
| MCP tools are unavailable              | Check that the subscription includes Management API and MCP authoring. |
| `solve_rule` fails with a missing key  | Create a Solver API key in the selected space.                         |
| The connection request expired         | Start a new connection from the MCP client.                            |

## Available Tools and Limitations

The Authoring MCP Server exposes DecisionRules authoring operations as MCP tools. The exact tools shown by your client can depend on the server version.

### Available capabilities

| Area          | What the MCP client can do                                                                              | Example tools                                                 |
| ------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| Rules         | Read, create, update, delete, version, lock, and change rule state.                                     | `get_latest_rule`, `create_rule`, `update_rule_version`       |
| Folders       | Read, create, rename, move, import, export, overwrite, and delete folder structures.                    | `get_folder_tree`, `create_folder`, `move_folder_nodes`       |
| Tags          | Find items by tag and add or remove tags from resources and versions.                                   | `list_items_by_tags`, `add_tags_to_item`                      |
| Analysis      | Find rule dependencies and duplicate rules.                                                             | `get_latest_rule_dependencies`, `find_latest_rule_duplicates` |
| Rule Flows    | Import and export Rule Flows and their versions.                                                        | `import_rule_flow`, `export_rule_flow_version`                |
| Tests         | List and manage tests and test suites.                                                                  | `list_test_suites`, `create_test`, `update_test_suite`        |
| Space         | List space items, create a space, and read owner statistics.                                            | `list_space_items`, `create_space`                            |
| Solving       | Execute a rule with input data.                                                                         | `solve_rule`                                                  |
| AI generation | Generate a Decision Table, Scripting Rule, or Lookup Table proposal from a natural-language assignment. | `generate_aia_resource`                                       |

## Important limitations

* A connection is limited to one selected space.
* Grant connection permission only to trusted users and clients.
* Delete and overwrite tools can permanently change space resources.
* `solve_rule` requires a Solver API key in the selected space.
* `generate_aia_resource` currently supports only Decision Tables, Scripting Rules, and Lookup Tables.
* Rule Flow authoring is currently limited to the exposed import and export tools.
* Subscription limits, structure limits, validation rules, and endpoint-specific restrictions still apply.
* This server does not search DecisionRules documentation. Use the separate documentation MCP server for documentation search.

{% hint style="info" %}
Before allowing an AI client to perform a large or destructive change, ask it to list the planned operations and review the affected resource IDs, paths, and versions.
{% endhint %}
