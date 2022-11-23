---
description: The Console Logs API is a secure REST API that provides console logs.
---

# Console Logs API

### Get Console Logs

This endpoint allows you to get console logs of specific solve.&#x20;

{% swagger method="get" path="/consoleLogs/:correlationId" baseUrl="https://api.decisionrules.io" summary="" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="query" name="correlationId" required="true" %}
CorrelationId of specific solve
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer <Solver API Key>
{% endswagger-parameter %}
{% endswagger %}

#### Getting correlationId

You can get correlationId from the response Header of Solver API. The correlationId has header key: **X-Correlation-Id.**

This correlationId is specific for every solve if the user does not specifies own correlationId.

#### Console Logs lifetime

The console logs are stored for 10 minutes at this moment.
