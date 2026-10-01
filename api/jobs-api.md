---
description: The Jobs API starts and manages jobs — background runs of Integration Flows.
---

# Jobs API

## Authentication

Every request needs a [**Solver API key**](api-keys/solver-api-keys.md) in the `Authorization` header:

```javascript
Authorization: Bearer <YOUR_SOLVER_API_KEY>
```

{% openapi-operation spec="jobs-api" path="/start/{identifier}/{ruleVersion}" method="post" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T142121Z&X-Amz-Expires=172800&X-Amz-Signature=08364a1322e325f0ccda994315c89a7c36eb326b9f4e712d7fe203ffbbc44c90&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="jobs-api" path="/cancel/{jobId}" method="post" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T142121Z&X-Amz-Expires=172800&X-Amz-Signature=08364a1322e325f0ccda994315c89a7c36eb326b9f4e712d7fe203ffbbc44c90&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="jobs-api" path="/cancelAll/space/{spaceId}" method="post" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T142121Z&X-Amz-Expires=172800&X-Amz-Signature=08364a1322e325f0ccda994315c89a7c36eb326b9f4e712d7fe203ffbbc44c90&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="jobs-api" path="/cancelAll/rule/{identifier}/{ruleVersion}" method="post" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T142121Z&X-Amz-Expires=172800&X-Amz-Signature=08364a1322e325f0ccda994315c89a7c36eb326b9f4e712d7fe203ffbbc44c90&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="jobs-api" path="/{jobId}" method="get" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T142121Z&X-Amz-Expires=172800&X-Amz-Signature=08364a1322e325f0ccda994315c89a7c36eb326b9f4e712d7fe203ffbbc44c90&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-schemas spec="jobs-api" schemas="JobState,JobStatusCode,JobStatus,JobRuleReference,Job,JobContext" grouped="true" %}
[OpenAPI jobs-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/9da099c9e0a433e483d0fff50a2426d697fef95c79833f4b058097df87495aaf.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T142121Z&X-Amz-Expires=172800&X-Amz-Signature=08364a1322e325f0ccda994315c89a7c36eb326b9f4e712d7fe203ffbbc44c90&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-schemas %}

## **Solver version**

Each job runs on one solver version. Set it with `solverVersion` in the request body when you start the job:

```json
{
  "inputData": {
    "client": { "age": 18 }
  },
  "solverVersion": "v2"
}
```

It takes `v1` or `v2`. If you leave it out, the job runs on `v1`. For what v2 offers, see Rule[ Solver API v2](rule-solver-api/rule-solver-api.md).
