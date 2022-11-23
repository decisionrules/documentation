---
description: The Console Logs API is a secure REST API that provides console logs.
---

# Console Logs API

### Get Console Logs

This endpoint allows you to get console logs of specific solve.&#x20;

{% swagger method="get" path="" baseUrl="https://api.decisionrules.io" summary="" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="query" name="correlationId" required="true" %}
CorrelationId of specific solve
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer <Solve API Key>
{% endswagger-parameter %}
{% endswagger %}
