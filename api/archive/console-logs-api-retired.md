---
description: The Console Logs API is a secure REST API that provides console logs.
---

# Console Logs API (RETIRED)

{% hint style="warning" %}
Console Logs API is retired from version 1.25.1. To save and fetch debug logs, please use Audit Logs with our Business Intelligence API.
{% endhint %}

{% openapi-operation spec="console-api" path="/{correlationId}" method="get" %}
[OpenAPI console-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/23a9db15591405dd3414800d4914ded886824ee55b4fe3ae0a2128a22bd8f15b.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20260427%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260427T174739Z&X-Amz-Expires=172800&X-Amz-Signature=02af16ae2fe302d6a5a5dd66252514eb2b1e495e214704e17598843ffc9186d4&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}



{% openapi-schemas spec="console-api" schemas="ConsoleLogEntry,LogsResponse" grouped="true" %}
[OpenAPI console-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/23a9db15591405dd3414800d4914ded886824ee55b4fe3ae0a2128a22bd8f15b.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20260427%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260427T174739Z&X-Amz-Expires=172800&X-Amz-Signature=02af16ae2fe302d6a5a5dd66252514eb2b1e495e214704e17598843ffc9186d4&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-schemas %}
