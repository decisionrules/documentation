---
description: The Jobs API starts and manages jobs — background runs of Integration Flows.
---

# Jobs API

## Authentication

Every request needs a [**Solver API key**](api-keys/solver-api-keys.md) in the `Authorization` header:

{% code collapsedlinecount="10" %}
```javascript
Authorization: Bearer <YOUR_SOLVER_API_KEY>
```
{% endcode %}

{% openapi-operation spec="jobs-api" path="/start/{identifier}/{ruleVersion}" method="post" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=b7e7e12544bee9a542f597f54075583532665bf2045cc830dfd477f9da832311&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="info" %}
On a space with [Space Versioning](../space/space-version-control/), add the `revisionIdentifier` query parameter to the start call — a revision tag, `PUBLISHED` or a revision ID — to run the job against that revision. The parameter is optional: without it the job runs against the published revision. The revision is fixed when the job starts and recorded on the job; the start response also returns `solverVersion`, `revisionId` and `ruleReference`. A revision that does not exist is refused with HTTP 400 _"Revision \<id> not found on space \<spaceId>."_ and no job is created. Getting a job (`GET /job/{jobId}`) needs no revision. See [API and Integrations](../space/space-version-control/api-and-integrations.md#jobs-api-and-rule-testing-api).
{% endhint %}

{% openapi-operation spec="jobs-api" path="/cancel/{jobId}" method="post" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=b7e7e12544bee9a542f597f54075583532665bf2045cc830dfd477f9da832311&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="jobs-api" path="/cancelAll/space/{spaceId}" method="post" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=b7e7e12544bee9a542f597f54075583532665bf2045cc830dfd477f9da832311&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="jobs-api" path="/cancelAll/rule/{identifier}/{ruleVersion}" method="post" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=b7e7e12544bee9a542f597f54075583532665bf2045cc830dfd477f9da832311&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="jobs-api" path="/{jobId}" method="get" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=b7e7e12544bee9a542f597f54075583532665bf2045cc830dfd477f9da832311&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-schemas spec="jobs-api" schemas="JobState,JobStatusCode,JobStatus,JobRuleReference,Job,JobContext" grouped="true" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=b7e7e12544bee9a542f597f54075583532665bf2045cc830dfd477f9da832311&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-schemas %}

## **Solver version**

Each job runs on one solver version. Set it with `solverVersion` in the request body when you start the job:

{% code collapsedlinecount="10" %}
```json
{
  "inputData": {
    "client": { "age": 18 }
  },
  "solverVersion": "v2"
}
```
{% endcode %}

It takes `v1` or `v2`. If you leave it out, the job runs on `v1`. For what AERO(v2) offers, see Rule[ Solver API AERO (v2](rule-solver-api/rule-solver-api.md)).
