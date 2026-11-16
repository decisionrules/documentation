# MCP Connections

The **MCP Connections** page provides an overview of active OAuth connections to the current space. Use it to check who connected an MCP client, to change what a connection may do, and to revoke connections that should no longer have access. In the space menu it is listed as **MCP Connection**.

## Connection list

Each connection shows:

| Field           | Description                                                                                 |
| --------------- | ------------------------------------------------------------------------------------------- |
| Connection Name | The MCP client used to connect, such as ChatGPT/Codex.                                      |
| User            | The user who authorized the connection.                                                     |
| Status          | The current status of the connection.                                                       |
| Scope           | What the connection may use: Management **Full Access** or **Readonly**, and/or **Solver**. |
| Created At      | When the connection was established.                                                        |
| Last Used       | When the connection was last used.                                                          |

## Change the scope of a connection

You can change what an existing connection may do without reconnecting the MCP client.

1. Find the connection in the list.
2. Open the **three-dot menu** at the end of its row.
3. Select **Edit scope**.
4. Choose the Management access level (**No Management access**, **Full Access** or **Readonly**) and whether **Solver** access is enabled, then save.

The new scope applies immediately to every token of that connection. You can select only scopes that both you and the user who authorized the connection are currently allowed to grant. If a current scope is no longer permitted, you can remove it but not select it again.

## Revoke a connection

1. Find the connection in the list.
2. Open the **three-dot menu** at the end of its row.
3. Select **Delete connection** and confirm the action.

Deleting a connection immediately removes that client's access to the space.

## Required permissions

* **View MCP Connections** is required to open the list.
* **Connect MCP Server** is required to change the scope of a connection.
* **Delete MCP Connection** is required to revoke a connection.
* Both **View MCP Connections** and **Delete MCP Connection** are required to manage and revoke connections in the UI.

<figure><img src="https://437457296-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MN4F4-qybg8XDATvios%2Fuploads%2Fyx3Z16Qv9gBhDcgWwwuy%2FStep7MCP.png?alt=media&#x26;token=aba6fdba-ca9b-4389-bf75-2369c5b48a91" alt=""><figcaption></figcaption></figure>

## Create a connection

Connect an MCP-compatible client to the **Authoring MCP Server** to create, manage, test, and execute resources in the selected space. Follow the setup guide: [here](../integrations/sdk-and-libraries/mcp-servers/#authoring-mcp-server)
