---
description: The Jobs API is a secure REST API that manage jobs.
---

# Jobs API

### Request authorization

{% hint style="info" %}
To authenticate your requests, you must use a Bearer token with a valid **Solver API key**.
{% endhint %}

For example:

```
Authorization: Bearer YOUR_SOLVER_API_KEY
```

{% openapi-operation spec="jobs-api" path="/start/{identifier}/{version}" method="post" %}
[OpenAPI jobs-api](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/b8b802dbbae5a2a692085243fb13fbefe573027d27c430d174a20122a05b2a6f.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250818%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250818T111246Z&X-Amz-Expires=172800&X-Amz-Signature=beee25e4e18b55c466476f1fb6c1314b2f6a116db7a99e7e12a95465189015c8&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="jobs-api" path="/cancel/{jobId}" method="post" %}
[OpenAPI jobs-api](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/b8b802dbbae5a2a692085243fb13fbefe573027d27c430d174a20122a05b2a6f.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250818%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250818T111246Z&X-Amz-Expires=172800&X-Amz-Signature=beee25e4e18b55c466476f1fb6c1314b2f6a116db7a99e7e12a95465189015c8&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="jobs-api" path="/cancelAll/space/{spaceId}" method="post" %}
[OpenAPI jobs-api](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/b8b802dbbae5a2a692085243fb13fbefe573027d27c430d174a20122a05b2a6f.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250818%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250818T111246Z&X-Amz-Expires=172800&X-Amz-Signature=beee25e4e18b55c466476f1fb6c1314b2f6a116db7a99e7e12a95465189015c8&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="jobs-api" path="/cancelAll/rule/{identifier}/{version}" method="post" %}
[OpenAPI jobs-api](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/b8b802dbbae5a2a692085243fb13fbefe573027d27c430d174a20122a05b2a6f.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250818%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250818T111246Z&X-Amz-Expires=172800&X-Amz-Signature=beee25e4e18b55c466476f1fb6c1314b2f6a116db7a99e7e12a95465189015c8&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="jobs-api" path="/{jobId}" method="get" %}
[OpenAPI jobs-api](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/b8b802dbbae5a2a692085243fb13fbefe573027d27c430d174a20122a05b2a6f.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250818%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250818T111246Z&X-Amz-Expires=172800&X-Amz-Signature=beee25e4e18b55c466476f1fb6c1314b2f6a116db7a99e7e12a95465189015c8&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-schemas spec="jobs-api" schemas="JobState,JobStatusCode,JobStatus,JobRuleReference,Job,JobContext" grouped="true" %}
[OpenAPI jobs-api](https://gitbook-x-prod-openapi.4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/raw/b8b802dbbae5a2a692085243fb13fbefe573027d27c430d174a20122a05b2a6f.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20250818%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20250818T111246Z&X-Amz-Expires=172800&X-Amz-Signature=beee25e4e18b55c466476f1fb6c1314b2f6a116db7a99e7e12a95465189015c8&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-schemas %}
