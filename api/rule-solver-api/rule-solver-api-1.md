---
description: Solve a rule on GAIA solver and get the result in the same call.
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

# Rule Solver API GAIA (v1)

Solver GAIA (v1) is no longer developed, and new features are released only on AERO (v2). We recommend moving to [Rule Solver API v2](rule-solver-api.md). See [Rule Solver API Migration](solver-version-migration.md) to learn how.

This page describes version 1 (GAIA) of the Rule Solver API. **It remains available for existing integrations.**

{% hint style="success" %}
In version 1.16.0 and newer Rule Flows are solved with this endpoint too. The separate Rule Flow Solver API is deprecated.
{% endhint %}

## Swagger

You can check out these endpoints and call them right away using swagger.

**Swagger UI:** [https://api.decisionrules.io/api/solver/docs](https://api.decisionrules.io/api/solver/docs/)

**Swagger JSON File:** [https://api.decisionrules.io/api/solver/docs/json](https://api.decisionrules.io/api/solver/docs/json)

{% openapi-operation spec="solver-api" path="/rule/v1/solve/{ruleId}/{ruleVersion}" method="post" %}
[OpenAPI solver-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/5ba9f1c6f647a4dfa54968263395bc5949f135d94e87d0852c843df964b6093d.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=5a94ed056756351f2e5719497960a4df24f725d1e4fcc4aafb52014339efb845&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

{% openapi-operation spec="solver-api" path="/rule/solve/{ruleId}/{ruleVersion}" method="post" %}
[OpenAPI solver-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/5ba9f1c6f647a4dfa54968263395bc5949f135d94e87d0852c843df964b6093d.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0cc7c3f440ca5fd44ab53362d4a69dfe%2F20261116%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261116T160111Z&X-Amz-Expires=172800&X-Amz-Signature=5a94ed056756351f2e5719497960a4df24f725d1e4fcc4aafb52014339efb845&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

## Query parameters

| Name                 | Type   | Description                                                                                                                                                                                                                                                                                                                                                                    |
| -------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `revisionIdentifier` | string | Space Versioning only. The revision to solve against: a revision tag name (for example `production`), the built-in `PUBLISHED` (exact case), or a revision ID. Any revision can be solved: a draft, a revision awaiting approval or approved, the published one or an archived one. When omitted, the published revision answers. Ignored on a space without Space Versioning. |

{% hint style="info" %}
On a space with [Space Versioning](../../space/space-version-control/), a solve without `revisionIdentifier` is answered from the published revision, so existing integrations keep working unchanged. Add `?revisionIdentifier=<tag or revision ID>` to test a draft or to pin an integration to a revision. A tag name is matched first, exactly as written; `PUBLISHED` must be written in capitals. The whole evaluation uses the named revision, including the rules the solved rule calls. An identifier that matches no tag and no revision is refused with _"Revision \<id> not found on space \<spaceId>."_ [AERO (v2)](rule-solver-api.md) (`/rule/v2/solve/...`) accepts the parameter the same way. See [API and Integrations](../../space/space-version-control/api-and-integrations.md#solver-api).
{% endhint %}
