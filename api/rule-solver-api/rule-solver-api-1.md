---
description: Solve a rule on Gaia solver and get the result in the same call.
cover: >-
  https://images.unsplash.com/photo-1555066931-4365d14bab8c?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHw4fHxjb2RlfGVufDB8fHx8MTYzNjk4NjM4Mg&ixlib=rb-1.2.1&q=85
coverY: 0
layout:
  width: wide
  cover:
    visible: true
    size: full
    mask: none
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
  tags:
    visible: true
  actions:
    visible: true
  anchors:
    visible: true
---

# Rule Solver API v1

Solver V1 is no longer developed, and new features are released only on V2. We recommend moving to [Rule Solver API v2](rule-solver-api.md). See [Rule Solver API Migration](solver-version-migration.md) to learn how.

This page describes version 1 of the Rule Solver API. **It remains available for existing integrations.**

{% hint style="success" %}
In version 1.16.0 and newer Rule Flows are solved with this endpoint too. The separate Rule Flow Solver API is deprecated.
{% endhint %}

## Swagger

You can check out these endpoints and call them right away using swagger.

**Swagger UI:** [https://api.decisionrules.io/api/solver/docs](https://api.decisionrules.io/api/solver/docs/)

**Swagger JSON File:** [https://api.decisionrules.io/api/solver/docs/json](https://api.decisionrules.io/api/solver/docs/json)

{% openapi-operation spec="solver-api" path="/rule/solve/{ruleId}/{ruleVersion}" method="post" %}
[OpenAPI solver-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/fef1df790a9b2afd67cdca40bf6d1ec2c25ffbc87622e4fd00441bdcdc93493c.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T123337Z&X-Amz-Expires=172800&X-Amz-Signature=37a7526032a58f66eed1ccf3abd9df759a784e3755e18ef995b33c72c6985a4f&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="solver-api" path="/rule/v1/solve/{ruleId}/{ruleVersion}" method="post" %}
[OpenAPI solver-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/fef1df790a9b2afd67cdca40bf6d1ec2c25ffbc87622e4fd00441bdcdc93493c.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T123337Z&X-Amz-Expires=172800&X-Amz-Signature=37a7526032a58f66eed1ccf3abd9df759a784e3755e18ef995b33c72c6985a4f&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="solver-api" path="/rule/solve/{ruleId}/{ruleVersion}" method="post" %}
[OpenAPI solver-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/fef1df790a9b2afd67cdca40bf6d1ec2c25ffbc87622e4fd00441bdcdc93493c.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T123337Z&X-Amz-Expires=172800&X-Amz-Signature=37a7526032a58f66eed1ccf3abd9df759a784e3755e18ef995b33c72c6985a4f&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}
