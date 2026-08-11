# MCP Connections

The **MCP Connections** page provides an overview of active OAuth connections to the current space. Use it to check who connected an MCP client and to revoke connections that should no longer have access.

## Connection list

Each connection shows:

| Field        | Description                                            |
| ------------ | ------------------------------------------------------ |
| Client       | The MCP client used to connect, such as ChatGPT/Codex. |
| User         | The user who authorized the connection.                |
| Status       | The current status of the connection.                  |
| Created at   | When the connection was established.                   |
| Last updated | When the connection was last updated.                  |

## Revoke a connection

1. Find the connection in the list.
2. Open the **three-dot menu** at the end of its row.
3. Select **Delete connection** and confirm the action.

Deleting a connection immediately removes that client's access to the space.

## Required permissions

* **View MCP Connections** is required to open the list.
* **Delete MCP Connection** is required to revoke a connection.
* Both permissions are required to manage and revoke connections in the UI.

<figure><img src="https://437457296-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MN4F4-qybg8XDATvios%2Fuploads%2Fyx3Z16Qv9gBhDcgWwwuy%2FStep7MCP.png?alt=media&#x26;token=aba6fdba-ca9b-4389-bf75-2369c5b48a91" alt=""><figcaption></figcaption></figure>

## Create a connection

Connect an MCP-compatible client to the **Authoring MCP Server** to create, manage, test, and execute resources in the selected space. Follow the setup guide: [here](../integrations/sdk-and-libraries/mcp-servers/#authoring-mcp-server)
