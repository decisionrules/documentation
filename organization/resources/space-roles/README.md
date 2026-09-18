# Space Roles

Space Roles within organizations define the permissions and capabilities that users have within specific spaces. Each Space Role grants different levels of access, allowing users to perform various actions based on their role. Space Roles ensure efficient collaboration, security, and resource management within individual spaces by regulating user permissions. Such roles are assigned to members or teams for a specific space when a [policy](../../policies.md) is created.

### Space role permissions

The **Permissions** tab offers **Simple** and **Advanced** permissions. Simple permissions are grouped by area, as listed below. Advanced permissions provide more detailed control over individual actions. For details, see [Permissions](permissions.md).

{% hint style="info" %}
You can choose either **Simple** or **Advanced** permissions. Only one of them will be used for the role.
{% endhint %}

* Space Permissions
  * **Read** - Can read the space.
  * **Update Space** - Can rename and delete the space.
  * **Update Space Access** - Can add or remove users and roles, change space permissions, and delete invitations.
* Rule Permissions
  * **Read** - Can read all kinds of rules and the folder structure.
  * **Update** - Can update, export, and import all kinds of rules.
  * **Lock Rule** - Can lock and unlock rules. Locking a rule prevents other users from editing it.
* API Keys Permissions
  * **View API Key** (legacy) - Can reveal all API-key types.
  * **List API-key metadata** - Can list API keys with their values masked.
  * **Reveal Solver API keys** - Can reveal Solver API keys.
  * **Reveal Management API keys** - Can reveal Management API keys.
  * **Reveal BI API keys** - Can reveal Business Intelligence API keys.
  * **Reveal read-only BI API keys** - Can reveal only read-only Business Intelligence API keys.
  * **Update** - Can create, rename, and delete API keys.
* Audits Permissions
  * **Read** - Can read audit logs. API-key reveal permissions are managed separately.
  * **Update** - Can update and delete audits.
* Folder Permissions
  * **Update** - Can update the folder structure and move rules and folders.
* Jobs Permissions
  * **Read** - Can read jobs.
  * **Update** - Can update and start jobs.
* Connectors Permissions
  * **Read** - Can read connectors.
  * **Update** - Can update connectors.
* Webhook Permissions
  * **Read** - Can read webhooks.
  * **Update** - Can update webhooks.
* MCP Connections Permissions
  * **View MCP Connections** - Can view MCP connections.
  * **Connect** - Can authorize access to MCP servers.
  * **Delete MCP Connection** - Can delete MCP connections.
* Tests Permissions
  * **Read** - Can read Tests and Test Runs.
  * **Update** - Can update and run Tests.
* AI Assistant Permissions
  * **Use** - Can use AI Assistant.

**List API-key metadata** allows users to see that a key exists without revealing its value. To reveal a key, grant the corresponding **Reveal** permission. API Keys **Update** requires **List API-key metadata** and does not by itself grant permission to reveal existing key values.

{% hint style="warning" %}
**View API Key** is a broad legacy permission that reveals all API-key types and may provide access to administrative actions. Use **List API-key metadata** and the individual **Reveal** permissions to control access by key type.
{% endhint %}

### Default space roles

There are two predefined roles in the organization that can be immediately assigned to users: **Editor** and **Reader**. These roles are marked as **Default** and managed by DecisionRules. You can view their permissions using **Detail**, but they cannot be edited or deleted. Create a custom role if you need different permissions.

* **Editor** - Includes all Simple permissions listed above except the legacy **View API Key** permission. It includes the individual permissions to reveal all API-key types.
* **Reader** - Includes Space **Read**, Rule **Read**, **List API-key metadata**, **Reveal read-only BI API keys**, Audits **Read**, Jobs **Read**, Connectors **Read**, Webhook **Read**, Tests **Read**, and AI Assistant **Use**. It does not include MCP Connections permissions.

{% hint style="info" %}
Default Space Roles are available for the Organization and all Departments.
{% endhint %}

### Create / Update space role

1. Click **Add Role** to create a new role. The dialog opens on the **Permissions** tab.
2. Select the permissions for the role using **Simple** or **Advanced** mode.
3. Open the **Metadata** tab and enter **Role Name** (required).
4. Optionally add a **Description** and select a **Department**, as described below.
5. Click **Create** to save the role.

{% hint style="warning" %}
**The role cannot be saved without a name.** The **Create** button stays disabled until you enter **Role Name** on the **Metadata** tab. The dialog opens on **Permissions**, so switch to **Metadata** to fill in the name.
{% endhint %}

To update a custom role, select **Edit** from its action menu, change its permissions or metadata, and click **Update**. **Role Name** must remain filled in.

Assigning to a Department:

* For Organization Owners / Admins: Selecting a Department is _optional_. Leaving it empty creates a Global Space Role that can be used anywhere.
* For Department Managers: Selecting a Department is _obligatory_, meaning the role will only be available for spaces within that specific department.

#### Moving Role Scopes

Organization Owners and Admins can reconfigure any existing role to change its location. This allows you to move roles:

* Global ↔ Department: Move roles from the organization level into a specific department (or vice versa).
* Cross-Department: Transfer roles directly between different departments.

### Delete space role

In Table layout, open the custom role’s action menu and select **Remove**.

{% hint style="warning" %}
Deleting a Space Role removes the access granted by that role to members and teams. Access granted by other roles is retained.
{% endhint %}

<figure><img src="../../../.gitbook/assets/SpaceRoleTab+ action.png" alt=""><figcaption><p>Delete Space role</p></figcaption></figure>
