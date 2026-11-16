---
description: >-
  The Management API is a secure REST API that provides read/write access to
  your rules and spaces.
cover: >-
  https://images.unsplash.com/photo-1623282033815-40b05d96c903?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwxfHxBUEl8ZW58MHx8fHwxNjM0NzM3NjYx&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Management API

API Request methods cheat sheet:&#x20;

{% hint style="info" %}
<mark style="color:$success;">GET</mark> - Used to **retrieve resource representation/information** and not modify it in any way, e.g., get a JSON representaition of a rule with the GET RULES endpoint.

<mark style="color:orange;">POST</mark> - Used to **create new subordinate resources**, e.g., creating a new rule in a Space or Importing a rule into a Space.

<mark style="color:blue;">PUT</mark> - Used primarily to **update an existing resource (if the resource does not exist, then API may decide to create a new resource or not),** e.g., updating a Rule Flow

<mark style="color:purple;">PATCH</mark> - Used to **make a partial update** on a resource, e.g., add Tags to an existing rule.

<mark style="color:red;">DELETE</mark> - Used to **delete resources,** e.g., deleting rules.
{% endhint %}

{% hint style="success" %}
<mark style="background-color:green;">**NEW in v1.16.0!**</mark> The Management API now fully support use of Rule Aliases when making requests.
{% endhint %}

{% hint style="info" %}
If you're using the **Regional Cloud** version of DecisionRules, read more about API calls [here](../other-deployment-options/regional-cloud/region-specific-api-urls.md#making-api-calls-on-region-cloud-accounts).
{% endhint %}

{% hint style="warning" %}
**Spaces with Space Versioning** — every Management API call for a versioned space has to name the revision it reads or writes with the `?revisionIdentifier=` query parameter (a revision tag, `PUBLISHED` or a revision ID), and writes are accepted only into draft revisions. Calls without it are refused with HTTP 400. See [Space Version Control — API and Integrations](../space/space-version-control/api-and-integrations.md).
{% endhint %}

## Swagger

You can check out these endpoints and call them right away using swagger.

**Swagger UI:** [https://api.decisionrules.io/api/docs/](https://api.decisionrules.io/api/docs/)

**Swagger JSON File:** [https://api.decisionrules.io/api/docs/json](https://api.decisionrules.io/api/docs/json)

## Folder Paths

{% hint style="success" %}
<mark style="background-color:green;">**NEW in v1.18.1**</mark> Some Management API Endpoints now support targetting by **Folder Path.**&#x20;
{% endhint %}

All Folder and select Rule endpoints now support targetting items by their folder path. Instead of having to provide the requests with Rule Aliases/IDs or Folder IDs users can now define the request target by leveraging the new **Folder Path functionality**.

#### Example:

To access **Calculation&#x20;**<mark style="color:orange;">**v2**</mark> (see image below), instead of appending it's rule ID to the request as a parameter you can now specify the ?path= query parameter.&#x20;

<figure><img src="../.gitbook/assets/image (2) (1) (1).png" alt="" width="216"><figcaption></figcaption></figure>

In this case to GET the rule the request would look like this:

{% code collapsedlinecount="10" %}
```
https://api.decisionrules.io/api/rule?path=/Client/Important/Calculation&version=2
```
{% endcode %}

To access the entire "Important" Folder the request could now look like this:

{% code collapsedlinecount="10" %}
```
https://api.decisionrules.io/api/folder?path=/Client/Important
```
{% endcode %}

{% hint style="warning" %}
* Request targets can be defined either by the ID **or** path, not both at the same time
* Folder Paths have to always begin with a slash "/"
* To target specific rule versions by path use the ?version= query parameter&#x20;
{% endhint %}

## Revisions

Available on spaces with [Space Versioning](../space/space-version-control/). The revision is named with `?revisionIdentifier=` exactly as on every other endpoint; no revision ID travels in the path. The full description of the release flow, the error codes and a CI/CD example are in [API and Integrations](../space/space-version-control/api-and-integrations.md).

### List revisions

`GET /api/revision/list` — the revisions of the space, newest first, as `{ items, total }`; paged with `?page=` (1-based) and `?pageSize=` (default 50, at most 200). Needs no revision identifier.

### Get revision

`GET /api/revision?revisionIdentifier=…` — one revision with its state, timestamps, description and rule count.

### Create draft revision

`POST /api/revision?revisionIdentifier=<source>` — creates a new draft from the named source. `PUBLISHED` gives a draft of what is live; any other revision (a draft, an archived release) is forked. Optional body `{ "name": "…", "description": "…" }`. Returns 201 with the new draft — send its `revisionId` on the following writes.

### Request approval / approve / publish

`POST /api/revision/request-approval`, `POST /api/revision/approve`, `POST /api/revision/publish` — move the named revision through the review flow. The same rules apply as in the UI: a draft without changes is not sent to review, conflicts with the published revision refuse the request (`REVISION_MERGE_CONFLICTS`), and a revision that fell behind the published one cannot be published (`REVISION_STALE_BASELINE`).

### Publish without review / force publish

`POST /api/revision/publish-direct` publishes a draft, in-review or approved revision in one step and records the skipped steps. `POST /api/revision/force-publish` publishes the named revision as-is, skipping every check — anything published since the revision was forked is overwritten.

### Set / delete revision tag

`PUT /api/revision/tag/{name}?revisionIdentifier=…` creates the tag or moves it to the named revision; optional body `{ "description": "…", "color": "…" }`. `DELETE /api/revision/tag/{name}` removes it (204, also when it did not exist). `PUBLISHED` is built in and cannot be set or deleted.

{% hint style="info" %}
Rolling back, archiving, deleting and commenting on revisions, resolving conflicts and listing tags are UI-only actions. To bring an archived revision back through the API, create a draft from it and publish that draft.
{% endhint %}

## Rules

{% openapi-operation spec="management-api" path="/rule/{identifier}/{version}?" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="info" %}
You can target the rule using [Folder Path](https://docs.decisionrules.io/doc/api/management-api#folder-paths) instead of the :ruleId and :version parameters.
{% endhint %}

{% hint style="info" %}
Get rule might be useful when you wish to create a new version of a rule. To do so you may GET the rule, manually change the `"version"`attribute of the returned JSON object and then use said object with the POST Create rule method. This will result in a new version of the rule being created.
{% endhint %}



{% openapi-operation spec="management-api" path="/rule" method="post" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="info" %}
You can create the rule in a specific folder by utilizing [Folder Path](https://docs.decisionrules.io/doc/api/management-api#folder-paths).
{% endhint %}

{% openapi-operation spec="management-api" path="/rule/{identifier}/{version}?" method="put" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="info" %}
You can target the rule using [Folder Path](https://docs.decisionrules.io/doc/api/management-api#folder-paths) instead of the :ruleId and :version parameters.
{% endhint %}

{% hint style="info" %}
Update rule might be useful when renaming a rule. First GET the rule you wish to rename, change the`name`attribute of the returned JSON object and then use PUT Update rule with the changed JSON object.
{% endhint %}

{% hint style="info" %}
Note that there are a few attributes of the rule that cannot be updated by the `PUT` endpoint. Namely, you cannot use `PUT` to change the rule ID, version and rule alias. Also, you cannot change the date of last update, since it gets updated automatically.
{% endhint %}

{% openapi-operation spec="management-api" path="/rule/status/{identifier}/{status}/{version}" method="put" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/rule/{identifier}/{version}?" method="delete" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="info" %}
You can target the rule using [Folder Path](https://docs.decisionrules.io/doc/api/management-api#folder-paths) instead of the :ruleId and :version parameters.
{% endhint %}

{% hint style="warning" %}
If you do not specify version of the rule to be deleted, the endpoint will delete **all versions of the rule**. Please, use it with caution! Once deleted, rules cannot be recovered.
{% endhint %}

{% openapi-operation spec="management-api" path="/rule/{identifier}/new-version" method="post" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="info" %}
This endpoint does not create a new rule. If no existing version of the rule is found, an error will be returned. Use the [Create rule](https://docs.decisionrules.io/doc/api/management-api#create-rule) endpoint instead.
{% endhint %}

{% hint style="info" %}
The rule’s name, alias, and ID will remain unchanged, regardless of the values provided in the request body.
{% endhint %}

{% openapi-operation spec="management-api" path="/rule/lock/{identifier}/{version}" method="patch" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="info" %}
You can target the rule using [Folder Path](https://docs.decisionrules.io/doc/api/management-api#folder-paths) instead of the :ruleId and :version parameters.
{% endhint %}

## Spaces

{% openapi-operation spec="management-api" path="/space/items" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

## Tags

{% openapi-operation spec="management-api" path="/tags/items" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/tags/{identifier}/{version}" method="patch" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/tags/{identifier}/{version}" method="delete" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

## Folders

{% openapi-operation spec="management-api" path="/folder/{nodeId}" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/folder/{nodeId}" method="post" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="info" %}
If the request body contains rules **(defined by baseId or ruleAlias)**, the are moved to fit with the request. In the request example below, if the space contains a rule with id "xxx-yyy-zzz", it will be moved into the newly created "Example Sub-Folder" Folder.

When moving Rules - If a version is not defined all of the rule versions will be moved.
{% endhint %}

{% openapi-operation spec="management-api" path="/folder/{nodeId}" method="put" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="warning" %}
Any existing Folder children of the target node will be deleted. (Rules, which aren't part of the request body will be moved to the root)
{% endhint %}

{% hint style="info" %}
If the request body contains rules **(defined by baseId or ruleAlias)**, the are moved to fit with the request. In the request example below, if the space contains a rule with id "xxx-yyy-zzz", it will be moved into the newly created "Example Sub-Folder" Folder.

When moving Rules - If a version is not defined all of the rule versions will be moved.
{% endhint %}

{% openapi-operation spec="management-api" path="/folder/{nodeId}" method="delete" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="danger" %}
Data removal is permanent and cannot be undone.
{% endhint %}

{% openapi-operation spec="management-api" path="/folder/export/{nodeId}" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/folder/import/{nodeId}" method="post" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="info" %}
You can target the rule using [Folder Path](https://docs.decisionrules.io/doc/api/management-api#folder-paths) instead of the :ruleId and :version parameters.
{% endhint %}

{% openapi-operation spec="management-api" path="/folder/move" method="put" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/folder/rename/{nodeId}" method="patch" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/folder/find" method="post" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

## Tools

{% openapi-operation spec="management-api" path="/tools/duplicates/{identifier}/{version}?" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/tools/dependencies/{identifier}/{version}?" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

## Test

{% openapi-operation spec="management-api" path="/test/{testSuiteId}" method="post" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/test/{testSuiteId}" method="put" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/test/move" method="put" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/test" method="delete" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

## Test Suite

{% openapi-operation spec="management-api" path="/testSuite/rule/{alias}/{version}" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/testSuite" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/testSuite" method="post" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/testSuite" method="put" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/testSuite" method="delete" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/testSuite/move" method="put" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/testSuite/import-generated" method="post" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

## Test Run

{% openapi-operation spec="management-api" path="/testRun" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/testRun/{testRunId}" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

## RuleFlow Export/Import

Following endpoints can be used only to export and import Rule Flows. For managing Workflows, please store your Workflows with dependent rules in folders, then use folder API endpoints.

{% openapi-operation spec="management-api" path="/api/rule-flow/export/{ruleFlowId}/{version}" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="management-api" path="/api/rule-flow/import" method="post" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="danger" %}
Importing rule flow with rules included can overwrite previously created or imported rules having the same ruleId.
{% endhint %}

## Statistics

{% openapi-operation spec="management-api" path="/statistics/owner" method="get" %}
[OpenAPI management-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/c0a5ff22a81161de57a6192408c1e2f636f89accacb97b0425e1714de0d752e3.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=fae4bb2ad8c9055c383e76249730091939830d5cee33ac123ed3e5a3daf9f589&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}
