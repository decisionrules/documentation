---
description: The Rule Testing API runs your saved tests and returns their results.
---

# Rule Testing API

## Authentication

Every request needs a [**Solver API key**](api-keys/solver-api-keys.md) in the `Authorization` header:

```javascript
Authorization: Bearer <YOUR_SOLVER_API_KEY>
```

{% openapi-operation spec="rule-testing-api" path="/start" method="post" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/d04a04433dbcf6bd5f42a38fb28f846c8bb483a8c7b51a1668bf31e60a50a9f9.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T123336Z&X-Amz-Expires=172800&X-Amz-Signature=3b34e47e4a100ab6b040500790bc058a8f7377643548868bc23cddb31c267d81&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="rule-testing-api" path="/{testRunId}" method="get" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/d04a04433dbcf6bd5f42a38fb28f846c8bb483a8c7b51a1668bf31e60a50a9f9.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T123336Z&X-Amz-Expires=172800&X-Amz-Signature=3b34e47e4a100ab6b040500790bc058a8f7377643548868bc23cddb31c267d81&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="rule-testing-api" path="/detail/{testRunId}" method="get" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/d04a04433dbcf6bd5f42a38fb28f846c8bb483a8c7b51a1668bf31e60a50a9f9.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T123337Z&X-Amz-Expires=172800&X-Amz-Signature=d1a90ae1f3a87c08a5df54ecd90137dc66aadef2702c400f792d04c86814a831&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-schemas spec="rule-testing-api" schemas="TestRunRule,TestSuiteRun,TestExecution,BaseType,BaseStatus,TestSuiteRunStatus,TestResultStatus,SolverStrategyEnum,JobState,JobStatus,Job" grouped="true" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/d04a04433dbcf6bd5f42a38fb28f846c8bb483a8c7b51a1668bf31e60a50a9f9.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T123337Z&X-Amz-Expires=172800&X-Amz-Signature=d1a90ae1f3a87c08a5df54ecd90137dc66aadef2702c400f792d04c86814a831&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-schemas %}

## **Solver version**

Each test run uses one solver version. Set it with `solverVersion` in the request body:

```json
{
  "testSuiteIds": ["<TEST_SUITE_ID>"],
  "solverVersion": "v2"
}
```

It takes `v1` or `v2`. If you leave it out, the tests run on `v1`. The test run detail shows the version it used, in `solverVersion`.

The same tests can run on either version. See [Rule Solver API Migration](rule-solver-api/solver-version-migration.md).

***
