---
description: The Rule Testing API runs your saved tests and returns their results.
---

# Rule Testing API

## Authentication

Every request needs a [**Solver API key**](api-keys/solver-api-keys.md) in the `Authorization` header:

{% code collapsedlinecount="10" %}
```javascript
Authorization: Bearer <YOUR_SOLVER_API_KEY>
```
{% endcode %}

{% openapi-operation spec="rule-testing-api" path="/start" method="post" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/3e422ace6ed2e91430215685a38d9c5ad0f5e7189d258bc6fa30b40b70054e2c.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=64607c2b9afd1c2d4517738dca3f811b88d4f639de66a432fa213f7365505f6c&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% hint style="warning" %}
On a space with [Space Versioning](../space/space-version-control/), the start call **must** name the revision whose tests should run with the `revisionIdentifier` query parameter — a revision tag, `PUBLISHED` or a revision ID. There is no published default as for jobs: without the parameter the call is refused with HTTP 400 _"This space is versioned — name the revision with ?revisionIdentifier=…"_, and an identifier that matches no tag and no revision with _"Revision identifier '…' matches no tag and no revision on this space."_ The revision is fixed when the run starts and recorded on it; the start response also returns `solverVersion`, `revisionId` and `ruleReferences`. Reading a test run by its ID needs no revision. See [API and Integrations](../space/space-version-control/api-and-integrations.md#jobs-api-and-rule-testing-api).
{% endhint %}

{% openapi-operation spec="rule-testing-api" path="/{testRunId}" method="get" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/3e422ace6ed2e91430215685a38d9c5ad0f5e7189d258bc6fa30b40b70054e2c.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=64607c2b9afd1c2d4517738dca3f811b88d4f639de66a432fa213f7365505f6c&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="rule-testing-api" path="/detail/{testRunId}" method="get" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/3e422ace6ed2e91430215685a38d9c5ad0f5e7189d258bc6fa30b40b70054e2c.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=64607c2b9afd1c2d4517738dca3f811b88d4f639de66a432fa213f7365505f6c&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-schemas spec="rule-testing-api" schemas="TestRunRule,TestSuiteRun,TestExecution,BaseType,BaseStatus,TestSuiteRunStatus,TestResultStatus,SolverStrategyEnum,JobState,JobStatus,Job" grouped="true" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/3e422ace6ed2e91430215685a38d9c5ad0f5e7189d258bc6fa30b40b70054e2c.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=64607c2b9afd1c2d4517738dca3f811b88d4f639de66a432fa213f7365505f6c&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-schemas %}

## **Solver version**

Each test run uses one solver version. Set it with `solverVersion` in the request body:

{% code collapsedlinecount="10" %}
```json
{
  "testSuiteIds": ["<TEST_SUITE_ID>"],
  "solverVersion": "v2"
}
```
{% endcode %}

It takes `v1` or `v2`. If you leave it out, the tests run on `v1`. The test run detail shows the version it used, in `solverVersion`.

The same tests can run on either version. See [Rule Solver API Migration](rule-solver-api/solver-version-migration.md).

***
