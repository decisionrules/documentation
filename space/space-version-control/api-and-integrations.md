---
description: >-
  The revisionIdentifier parameter on the Solver, Management, Jobs and Testing
  APIs, CI/CD pipelines, webhooks and MCP.
---

# API and Integrations

On a versioned space the Solver API, the Management API, the Jobs API and the Rule Testing API all name a revision the same way: with the `revisionIdentifier` query parameter. This page explains the parameter, what changes for each API, how to update a CI/CD pipeline, and what webhooks and MCP clients get.

### Naming a Revision: `revisionIdentifier`

```
?revisionIdentifier=<tag name | PUBLISHED | revision ID>
```

* A **tag name** is matched first, exactly and case-sensitively (`production` is not `Production`). See [Revision Tags](revision-tags.md).
* **`PUBLISHED`** is the built-in tag of the published revision. It is matched exactly like a tag name, so write it in capitals: `published` is refused as an unknown revision.
* Anything else is treated as a **revision ID**. You find it in the URL of the revision's detail page in the UI, or in the response of `GET /api/revision/list`.
* A value that matches neither a tag nor a revision is refused with HTTP 400. The Management API and `POST /testRun/start` answer _"Revision identifier '…' matches no tag and no revision on this space."_; the Solver API and `POST /job/start` answer _"Revision \<id> not found on space \<spaceId>."_
* On a space **without** Space Versioning the parameter is ignored. An integration can send it on every space it talks to; nothing breaks when versioning is switched off.

Any revision can be targeted this way — a draft, a revision awaiting approval or approved, the published one or an archived one. Targeting a **draft** is how an external system tests a change before anyone publishes it: point Solver API calls at the draft with `?revisionIdentifier=<draft ID>` and compare the answers.

### Solver API

Nothing changes for existing calls: a solve without `revisionIdentifier` is answered from the **published revision**.

```
POST https://api.decisionrules.io/rule/v2/solve/{ruleId}/{version}
POST https://api.decisionrules.io/rule/v2/solve/{ruleId}/{version}?revisionIdentifier=production
POST https://api.decisionrules.io/rule/v2/solve/{ruleId}?revisionIdentifier=4d8e0b5e-…
POST https://api.decisionrules.io/rule/v1/solve/{ruleId}/{version}?revisionIdentifier=production
```

* The whole evaluation uses the named revision, including rules that the solved rule calls (Decision Flow nodes, `DR.solve` in Scripting Rules, Lookup Tables).
* Without a rule version in the URL, the solver takes the newest rule version that has the _published_ rule status **inside that revision**.
* Both solvers honour `revisionIdentifier` the same way: [AERO (v2)](../../api/rule-solver-api/rule-solver-api.md) on `/rule/v2/solve/...`, and [GAIA (v1)](../../api/rule-solver-api/rule-solver-api-1.md) on `/rule/v1/solve/...` and the older `/rule/solve/...` path.
* The [Kafka Solver API](../../api/apache-kafka-solver-api.md) always evaluates the published revision.
* Audit logs record the revision of every solve made through the HTTP Solver API; the Decision Intelligence screens can filter by it. Kafka solves are audited without a revision.

### Jobs API and Rule Testing API

`POST /job/start/{ruleId}/{version}` accepts `revisionIdentifier` too; without the parameter the job runs against the published revision. A revision that does not exist is refused with HTTP 400 _"Revision \<id> not found on space \<spaceId>."_ and no job is created.

On a versioned space `POST /testRun/start` and `GET /api/testRun` (the list of test runs, which lists only the runs started on the named revision) **require** `revisionIdentifier`. Without it they answer HTTP 400 _"This space is versioned — name the revision with ?revisionIdentifier=…"_. There is no published default as for jobs, so a CI step that starts test runs must name the revision, for example `?revisionIdentifier=PUBLISHED`. `GET /api/testRun/{testRunId}` needs no revision.

The revision is fixed when the job or the test run starts and stays the same for the whole run, even if a new revision is published meanwhile. The job and the test run record the revision they ran against, and the responses of `/job/start` and `/testRun/start` include `solverVersion`, `revisionId` and the rule reference (`ruleReference` for a job, `ruleReferences` for a test run).

### Management API

On a versioned space **every** Management API call has to name the revision it reads or writes. The Management API never guesses — not even the published revision:

```
GET https://api.decisionrules.io/api/rule/{ruleId}?revisionIdentifier=PUBLISHED
PUT https://api.decisionrules.io/api/rule/{ruleId}?revisionIdentifier=4d8e0b5e-…
```

| Situation                                                                                                                                  | Response                                                                                                                                                                                                                                                |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| No `revisionIdentifier`                                                                                                                    | HTTP 400 — _"This space is versioned — name the revision with ?revisionIdentifier=\<tag name or revision id> (PUBLISHED names the active published revision). List revisions via GET /api/revision/list; manage tags via PUT /api/revision/tag/:name."_ |
| Unknown tag or ID                                                                                                                          | HTTP 400 — _"Revision identifier '…' matches no tag and no revision on this space."_                                                                                                                                                                    |
| A content write — creating, changing, moving or deleting rules, folders, tests or test suites — that names a revision which is not a draft | HTTP 400 — _"Revision '…' is PUBLISHED — only draft (EDITING) revisions can be edited. Point your tag at a draft, or create one via POST /api/revision?revisionIdentifier=\<source revision>."_                                                         |
| A revision lifecycle call on a space without versioning                                                                                    | HTTP 400 with error code `VERSIONING_NOT_ENABLED`. `GET /api/revision/list` is the exception: it returns the stored list, which is usually empty.                                                                                                       |
| `POST /api/revision` when the account does not have Space Versioning, or has used up its revisions                                         | HTTP 426 — _"Space Versioning is not available on your current plan."_ or _"Revision limit reached (\<count>/\<limit>). Delete an old revision in one of the account's spaces or upgrade your plan."_                                                   |
| `request-approval` or `publish-direct` on a draft whose catch-up with the published revision would exceed a plan limit                     | HTTP 426 — _"After catching up with the published revision, this revision would count \<n> rules against your plan's limit of \<limit>. Delete some of them in the revision, then retry."_ Nothing is written.                                          |

Every HTTP 426 message ends with _"Please upgrade your plan or contact our support (support@decisionrules.io)."_ Errors are returned as `{ "error": { "message": "…", "code": "…" } }`; the error codes named on this page, such as `VERSIONING_NOT_ENABLED` or `REVISION_MERGE_CONFLICTS`, are in `error.code`.

* **Reads** — `GET` endpoints and the two search endpoints `POST /api/rule/find` and `POST /api/folder/find` — can name any revision.
* **Content writes** are accepted only into a draft. Nothing is written before the check. The lifecycle calls below name other revisions on purpose (for example the approved revision to publish, or the revision a tag should point at).
* Five calls need no revision because they do not touch one: `GET /api/revision/list`, `DELETE /api/revision/tag/{name}`, `POST /api/space`, `GET /api/statistics/owner` and `GET /api/testRun/{testRunId}`.

{% hint style="warning" %}
**Existing integrations stop working the moment Space Versioning is enabled** on the space they use, until they send `revisionIdentifier`. This covers every Management API call, test runs started with `POST /testRun/start`, and MCP clients. Solver API calls and job starts keep working and use the published revision. For scripts that only read or run tests, `?revisionIdentifier=PUBLISHED` restores the old behaviour. Scripts that write need a draft — see [Updating a CI/CD Pipeline](api-and-integrations.md#updating-a-ci-cd-pipeline).
{% endhint %}

#### Revision lifecycle endpoints

| Method and path                       | `revisionIdentifier` names…                                   | Body                                                                              | Result                                                                                                                                                                                                                  |
| ------------------------------------- | ------------------------------------------------------------- | --------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `GET /api/revision/list`              | —                                                             | —                                                                                 | `{ items: [...], total }`, newest first; paged with `?page=` (1-based) and `?pageSize=` (default 50, at most 200 — a larger value is refused with HTTP 400)                                                             |
| `GET /api/revision`                   | the revision to read                                          | —                                                                                 | the revision                                                                                                                                                                                                            |
| `POST /api/revision`                  | the **source** the new draft is forked from                   | `{ name?, description? }` (name at most 120 characters, description at most 2000) | HTTP 201, the new draft. `PUBLISHED` as the source is the usual "new draft"; any other source is a fork of it                                                                                                           |
| `POST /api/revision/request-approval` | the draft                                                     | —                                                                                 | the revision, now awaiting approval — or unchanged when the draft has no changes. Changes published since the draft was created are pulled into it first when they do not conflict; the response then carries `catchUp` |
| `POST /api/revision/approve`          | the revision awaiting approval                                | —                                                                                 | the revision, now approved                                                                                                                                                                                              |
| `POST /api/revision/publish`          | the approved revision                                         | —                                                                                 | the revision, now published                                                                                                                                                                                             |
| `POST /api/revision/publish-direct`   | a draft, a revision awaiting approval or an approved revision | —                                                                                 | published in one step, the skipped review steps recorded; an outdated draft is caught up first in the same way                                                                                                          |
| `POST /api/revision/force-publish`    | a draft, a revision awaiting approval or an approved revision | —                                                                                 | published as-is, skipping every check                                                                                                                                                                                   |
| `PUT /api/revision/tag/{name}`        | the revision the tag should point at                          | `{ description?, color? }`                                                        | the tag — created or moved. A tag name is 1–64 letters, digits, `-` or `_`, must not look like a revision ID, and `PUBLISHED` is reserved in any letter case                                                            |
| `DELETE /api/revision/tag/{name}`     | —                                                             | —                                                                                 | HTTP 204, also when the tag did not exist                                                                                                                                                                               |

Each revision is returned with `revisionId`, `name`, `state` (`EDITING`, `IN_REVIEW`, `APPROVED`, `PUBLISHED`, `ARCHIVED`), `createdAt`, `publishedAt` (when it went live, if ever), `closedAt` (when it stopped accepting changes), `description`, `rulesCount` (the number of rule versions), `contributors`, `comments` and `stateTransitions` (the activity of the revision — who moved it to which state and when). The items of `GET /api/revision/list` leave out `comments` and carry only the first entry of `stateTransitions`, the one that records how the revision was created. Send the `revisionId` you get back on the following calls: a tag can be moved by someone else, an ID cannot.

The lifecycle rules of the UI apply unchanged: a draft with no changes is not sent for approval (`request-approval` returns it unchanged) and cannot be published directly (_"No changes in this draft — nothing to publish."_), conflicts with the published revision refuse `request-approval` (error code `REVISION_MERGE_CONFLICTS`), and a revision that fell behind the published one cannot be published (`REVISION_STALE_BASELINE`) — resolve it in the UI or fork a fresh draft. A draft without a name is called _Revision YYYY-MM-DD HH:MM_ (UTC).

{% hint style="info" %}
The Management API covers the release path. These actions are UI-only: rolling back, archiving, deleting, requesting changes, resolving conflicts, commenting, listing tags, editing or renaming a tag, renaming a revision or editing its description, enabling or disabling Space Versioning, restoring a rule from the Recycle Bin and restoring a version from rule history. To bring an archived revision back through the API, create a draft from it (`POST /api/revision?revisionIdentifier=<archived revision>`) and publish that draft.
{% endhint %}

Everything done through the Management API is recorded under the API key, and a Management API key is not limited by space roles — it can publish and force-publish. Keep it with the systems that are allowed to release. All endpoints are also in the Swagger UI: [https://api.decisionrules.io/api/docs/](https://api.decisionrules.io/api/docs/).

### Updating a CI/CD Pipeline

A pipeline that deploys rules with the Management API — export from one space, import into another — has to make three changes for a versioned target space. The example below is a **first deployment**: it imports the rules of the source space into a fresh draft of the target space.

1. **Create a draft** to write into: `POST /api/revision?revisionIdentifier=PUBLISHED` with a name that identifies the pipeline run. Keep the `revisionId` from the response.
2. **Send `?revisionIdentifier=<revisionId>`** on every write and on every read that should see the draft's content. Reads from the source space use `?revisionIdentifier=PUBLISHED` (on a versioned source) to export what is live.
3. **Release the draft.** Either hand it to people — stop after `POST /api/revision/request-approval` and let a reviewer approve and publish in the UI — or publish from the pipeline with `POST /api/revision/publish-direct` (the pipeline's key needs no extra permission for that). Finally move the tag your consumers use: `PUT /api/revision/tag/production?revisionIdentifier=<revisionId>`.

{% hint style="warning" %}
`POST /api/folder/import` creates new rules: every imported rule gets a new ID, and the exported folder tree is added as a new folder. Running the same import again into the same space adds a second copy of every rule. The aliases are kept, so solving by alias then fails with _"Could not solve due to possible duplication in rule aliases…"_. To promote changes to rules that already exist in the target space, update them in the draft with `PUT /api/rule/{ruleId}/{version}?revisionIdentifier=<revisionId>`, or delete the target folder in the draft before importing.
{% endhint %}

```bash
set -e
API=https://api.decisionrules.io/api
SRC="Authorization: Bearer $SOURCE_SPACE_MANAGEMENT_KEY"
DST="Authorization: Bearer $TARGET_SPACE_MANAGEMENT_KEY"

# 0. export what is live in the source space
curl --fail -s "$API/folder/export?revisionIdentifier=PUBLISHED" -H "$SRC" > export.json

# 1. a draft of what is live in the target space
REV=$(curl --fail -s -X POST "$API/revision?revisionIdentifier=PUBLISHED" -H "$DST" \
  -H "Content-Type: application/json" -d '{"name":"pipeline #'"$BUILD_NUMBER"'"}' | jq -r .revisionId)

# 2. write into the draft (first deployment: the rules do not exist in the target yet)
curl --fail -s -X POST "$API/folder/import/root?revisionIdentifier=$REV" -H "$DST" \
  -H "Content-Type: application/json" --data-binary @export.json

# 3. publish it and move the tag
curl --fail -s -X POST "$API/revision/publish-direct?revisionIdentifier=$REV" -H "$DST"
curl --fail -s -X PUT "$API/revision/tag/production?revisionIdentifier=$REV" -H "$DST" \
  -H "Content-Type: application/json" -d '{}'
```

The pipeline's Solver API smoke tests can run against the draft before it is published: `?revisionIdentifier=$REV` on the solve call. Read more about pipelines in [CD/CI Pipelines](../../other-deployment-options/docker-and-on-premise/cd-ci-pipelines/).

### Webhooks and Event Logs

[Webhooks](../webhooks.md) can subscribe to the **Revisions** event group:

* **Versioning Enabled** / **Versioning Disabled** — `REVISION.ENABLED`, `REVISION.DISABLED`
* **Revision Created** — `REVISION.CREATED` for every new draft, a fork included, with `sourceRevisionId` and `sourceRevisionName` (the revision the draft was created from)
* **Revision Updated** — `REVISION.UPDATED` (name or summary changed)
* **Revision Approval Requested** / **Revision Changes Requested** / **Revision Approved** — `REVISION.SENT_TO_REVIEW`, `REVISION.CHANGES_REQUESTED`, `REVISION.APPROVED`
* **Revision Published** — `REVISION.PUBLISHED`, with `publishPath` = `REVIEW` (after approval), `DIRECT` (without approval), `FORCE` or `ROLLBACK`. A rollback also carries `sourceRevisionId` and `sourceRevisionName`, the revision whose content is live again. This is the event to build deployments on.
* **Revision Archived** / **Revision Deleted** — `REVISION.ARCHIVED`, `REVISION.DELETED`
* **Tag Created** / **Tag Moved** / **Tag Updated** / **Tag Deleted** — `REVISION.TAG_CREATED`, `REVISION.TAG_MOVED`, `REVISION.TAG_UPDATED`, `REVISION.TAG_DELETED` (with `tagName`). **Tag Updated** reports a tag that was renamed or whose description or colour changed; on a rename it also carries `previousTagName`. Saving a tag without changing anything sends no event.

The `data` of a revision event carries `revisionId` and `revisionName`. Every publish, a rollback included, first sends **Revision Archived** for the revision it replaced, with `supersededByRevisionId` and `supersededByRevisionName` of the revision published in its place. A revision archived by hand has neither field.

Rule events (`RULE.CREATED`, `RULE.UPDATED`, `RULE.DELETED`) raised on a versioned space carry `revisionId` and `revisionName` of the draft the change was made in, so a receiver can tell draft work from a release. Job events carry the revision the job ran against. In the UI, Event Logs list the revision of every entry and can be filtered by it — see [Event Logs](../event-logs-service-logs-and-notifications.md). Service Logs do not record a revision.

### MCP and the AI Assistant

The [Authoring MCP Server](../../integrations/sdk-and-libraries/mcp-servers/authoring-mcp-server.md) exposes the Management API, so an MCP client works with revisions the same way:

* Every Management tool that reads or writes the content of the space takes `revisionIdentifier`; on a versioned space it is required. That includes the AI tools such as `propose_rule_edit`, `generate_unsolved_test_suite` and `import_process`: generation reads the named revision, and `import_process` and `solve_and_import_test_suites` write only into a draft. Tools that do not work inside a revision, such as `list_revisions`, `delete_revision_tag`, the account-level tools and the test-run detail, take no identifier.
* The lifecycle tools `list_revisions`, `get_revision`, `create_revision`, `request_revision_approval`, `approve_revision`, `publish_revision`, `publish_revision_direct`, `force_publish_revision`, `set_revision_tag` and `delete_revision_tag` let an agent create a draft, work in it, request approval for it or publish it. The tools that change a revision or a tag need the **MCP Authoring Full Access** scope; a connection with **MCP Authoring Readonly** can only list and read revisions. `force_publish_revision` and `delete_revision_tag` are marked as destructive.
* `solve_rule`, `start_job` and `execute_tests` take `revisionIdentifier` as well, so an agent can test its draft before requesting approval.

The recommended flow for an agent is: `create_revision` with `revisionIdentifier=PUBLISHED`, use the returned `revisionId` on every following call, and end with `request_revision_approval` so that a person publishes.

The AI Assistant in the UI works in the revision you have switched to: it reads that revision and, when that revision is a draft, saves its changes into it.

{% hint style="warning" %}
Current limitations on versioned spaces:

* Switching the revision starts a new AI Assistant chat, and a proposal the assistant made in another revision cannot be applied.
* An MCP connection with **MCP Authoring Full Access** calls the Management API with the space's Management API key, so its tools are not limited by the connected user's Space Versioning permissions — it can publish and force-publish. See [Roles and Permissions](roles-and-permissions.md).
{% endhint %}
