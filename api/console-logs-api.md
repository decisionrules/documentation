---
description: The Console Logs API is a secure REST API that provides console logs.
---

# Console Logs API

### Get Console Logs

This endpoint allows you to get console logs of specific solve.&#x20;

{% swagger method="get" path="" baseUrl="https://api.derul" summary="" expanded="false" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="corelationId" required="true" %}
Solve correlation id
{% endswagger-parameter %}

{% swagger-parameter in="header" required="true" name="Authorization" %}
Bearer <Solver API Key>
{% endswagger-parameter %}
{% endswagger %}
