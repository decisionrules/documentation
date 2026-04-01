---
description: The Rule Testing API is a secure REST API that manage test runs.
---

# Rule Testing API

### Request authorization

{% hint style="info" %}
To authenticate your requests, you must use a Bearer token with a valid **Solver API key**.
{% endhint %}

For example:

```
Authorization: Bearer YOUR_SOLVER_API_KEY
```

{% openapi-operation spec="rule-testing-api" path="/start" method="post" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/d04a04433dbcf6bd5f42a38fb28f846c8bb483a8c7b51a1668bf31e60a50a9f9.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20260401%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260401T140800Z&X-Amz-Expires=172800&X-Amz-Signature=f4a26f7640e5332ce1fdcab069cbb9c92d63566b1f937c6bfbbf992b36a7a9e1&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="rule-testing-api" path="/{testRunId}" method="get" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/d04a04433dbcf6bd5f42a38fb28f846c8bb483a8c7b51a1668bf31e60a50a9f9.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20260401%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260401T140800Z&X-Amz-Expires=172800&X-Amz-Signature=f4a26f7640e5332ce1fdcab069cbb9c92d63566b1f937c6bfbbf992b36a7a9e1&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="rule-testing-api" path="/detail/{testRunId}" method="get" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/d04a04433dbcf6bd5f42a38fb28f846c8bb483a8c7b51a1668bf31e60a50a9f9.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20260401%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260401T140800Z&X-Amz-Expires=172800&X-Amz-Signature=f4a26f7640e5332ce1fdcab069cbb9c92d63566b1f937c6bfbbf992b36a7a9e1&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-schemas spec="rule-testing-api" schemas="TestRunRule,TestSuiteRun,TestExecution,BaseType,BaseStatus,TestSuiteRunStatus,TestResultStatus,SolverStrategyEnum,JobState,JobStatus,Job" grouped="true" %}
[OpenAPI rule-testing-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/d04a04433dbcf6bd5f42a38fb28f846c8bb483a8c7b51a1668bf31e60a50a9f9.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20260401%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260401T140800Z&X-Amz-Expires=172800&X-Amz-Signature=f4a26f7640e5332ce1fdcab069cbb9c92d63566b1f937c6bfbbf992b36a7a9e1&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-schemas %}
