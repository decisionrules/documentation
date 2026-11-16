---
description: >-
  The Space Versioning permissions, the default roles, and how to separate
  authors from reviewers.
---

# Roles and Permissions

Space Versioning adds a **Space Versioning Permissions** group to [Space Roles](../../organization/resources/space-roles/). Use it to decide who may change the space, who reviews, and who publishes.

### Space Versioning Permissions

| Permission                     | Description                                                                                                | What it unlocks                                                                                                                                                        |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Change Versioning Settings** | Can change the Space Versioning setting on a space                                                         | **Enable Versioning** and **Disable Versioning**                                                                                                                       |
| **Request Approval**           | Can request approval of a draft revision                                                                   | **Request Approval**                                                                                                                                                   |
| **Approve / Reject**           | Can approve revisions awaiting approval or reject them back to draft                                       | **Approve** and **Request Changes**                                                                                                                                    |
| **Publish**                    | Can publish approved revisions, publish without review, force-publish and roll back to an earlier revision | **Publish**, **Publish without Review**, **Force Publish** and **Roll back to this version**                                                                           |
| **Manage Revisions**           | Can fork, rename, describe, archive, delete and tag revisions                                              | Creating drafts (**Fork**), renaming and describing a revision, **Archive**, **Delete**, creating, editing (description and colour), moving and deleting revision tags |
| **Comment**                    | Can comment on active revisions                                                                            | Comments on drafts, revisions awaiting approval and approved revisions                                                                                                 |

In the **Advanced** view of the role editor the same permissions are listed in the **Space Versioning** category as **Change Versioning Settings**, **Request Revision Approval**, **Approve / Reject Revision**, **Publish Revision**, **Manage Revisions** and **Comment on Revisions**.

{% hint style="info" %}
The Space Versioning permissions apply only to spaces that belong to an organization. In the role editor of a private space the group is shown greyed out with the tooltip "Space Versioning is available only on organization-owned spaces."
{% endhint %}

The existing rule permissions keep their meaning inside revisions:

* **Read Rule** lets a user open the **Revisions** section, revision details, comparisons, revision tags, the Recycle Bin and the rule history. The test suite part of a comparison also needs **Read** in **Tests Permissions**.
* **Update Rule** is needed to change rules in a draft, to **Resolve Conflicts** and to restore a version from the history.
* **Create Rule** is needed to restore a rule from the Recycle Bin. A restored rule comes back like a newly created one, so it also counts against the plan's rule limit.
* **View Rule history** is needed for the History panel of a rule.

{% hint style="info" %}
Reviewing needs nothing beyond **Read Rule** and **Approve / Reject**, plus **Read** in **Tests Permissions** to see test suite changes. A reviewer does not need **Update Rule** to compare revisions, read the rules of a revision or run the Test Bench against it.
{% endhint %}

### Default Roles

* **Editor** includes all six Space Versioning permissions.
* **Reader** includes none of them. A Reader can browse revisions, comparisons, tags, the Recycle Bin and the rule history, but cannot comment, create drafts or change any revision's state.
* Custom roles pick any combination.

### Separating Authors from Reviewers

Space Versioning does not stop a user from approving or publishing a revision they wrote. If your process requires two pairs of eyes, express it in roles:

| Role (example)  | Rule permissions | Space Versioning permissions                |
| --------------- | ---------------- | ------------------------------------------- |
| Author          | Read, Update, …  | Request Approval, Manage Revisions, Comment |
| Reviewer        | Read             | Approve / Reject, Comment                   |
| Release manager | Read             | Publish, Comment                            |

Assign the roles to members or teams with [policies](../../organization/policies.md). An Author without **Approve / Reject** sees no **Approve** button. A revision awaiting approval is frozen for everyone, so a Reviewer needs no **Update Rule**: when something has to change, the reviewer clicks **Request Changes** and the revision returns to Draft.

Leave the following permissions out of the Author and Reviewer roles, because each of them lets a user release without **Publish**:

* **Reveal Management API keys**, and the legacy **View API Key**, which reveals every key of the space. A Management API key is not limited by Space Versioning permissions.
* **MCP Authoring Full Access** — see the warning below.

The predefined **Editor** role includes **Reveal Management API keys** and **MCP Authoring Full Access**, so build Author and Reviewer roles as custom roles.

{% hint style="warning" %}
**Management API keys and MCP Authoring Full Access are not limited by Space Versioning permissions.** A Management API key can run the whole lifecycle — create drafts, approve, publish and force-publish. So can an MCP client that a user connected with **MCP Authoring Full Access**: its tools call the Management API with the space's Management key, whatever Space Versioning permissions that user has. A connection with only **MCP Authoring Readonly** cannot create, approve or publish revisions. Treat Management API keys as secrets, and give them and **MCP Authoring Full Access** only to people and systems that are allowed to release. See [API and Integrations](api-and-integrations.md).
{% endhint %}
