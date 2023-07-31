---
cover: ../../.gitbook/assets/ruleFlowConnecting.PNG
coverY: 0
---

# Rule Flow Solver API (DEPRECATED)

{% hint style="warning" %}
In version 1.16.0 and newer you can solve your ruleflow with **Rule Solver API** endpoint.

Rule flow Solver API endpoint is now depreated.
{% endhint %}

### Solve RuleFlow

Solves desired RuleFlow stored in decisionRules.

{% swagger baseUrl="https://api.decisionrules.io/" path="composition/solve/:ruleFlowId/:version" method="post" summary="RuleFlow Solver" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="ruleFlowId" type="string" required="false" %}
Unique RuleFlow ID that is the same to all versions. You can also use the rule alias.
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" required="false" %}
RuleFlow version. If the parameter is not filled in, the last published version will be used automatically.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="false" %}
Bearer
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Content-Type" type="string" required="false" %}
application/json
{% endswagger-parameter %}

{% swagger-parameter in="body" name="data" type="object" required="false" %}
JSON object that describes the input json data
{% endswagger-parameter %}

{% swagger-parameter in="header" name="X-Strategy" type="string" required="false" %}
STANDARD or ARRAY or FIRST_MATCH
{% endswagger-parameter %}

{% swagger-parameter in="header" name="X-Audit" type="string" %}
Decides whether an audit of the solve should be created and saved. In case you want the audit to be created and saved, input "true".
{% endswagger-parameter %}

{% swagger-parameter in="header" name="X-Audit-Ttl" type="string" %}
A number that dictates after how many days the audit will be deleted.
{% endswagger-parameter %}

{% swagger-response status="200" description="" %}
```
[
  {
    "loan": 30000,
    "tax": 1.15,
    "message": "eligible for the loan"
  }
]
```
{% endswagger-response %}

{% swagger-response status="400" description="" %}
```
{
    "error": {
        "message": "Unknown ruleFlow or version"
    }
}
```
{% endswagger-response %}

{% swagger-response status="401" description="" %}
```
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endswagger-response %}
{% endswagger %}

{% hint style="info" %}
If you're using the **Regional Cloud** version of DecisionRules, read more about API calls [here](../../regional-cloud/region-specific-api-urls.md#making-api-calls-on-region-cloud-accounts).
{% endhint %}

{% hint style="info" %}
See  [**execution strategies**](../../other/execution-strategy.md) to change solver output format.
{% endhint %}

#### Request example

```http
URL
https://api.decisionrules.io/composition/solve/:ruleFlowId/:version

Headers:
Content-Type: application/json
Authorization: Bearer DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH
```

{% hint style="info" %}
Note that you can use **rule alias** instead of rule ID to identify the rule flow. In that case, make sure that the rule alias is unique within the space, otherwise the request will fail.
{% endhint %}

{% hint style="info" %}
This API Key. Generate your own [here](https://app.decisiongrid.io/api-keys)
{% endhint %}

```javascript
{
    "data": {
        // INPUT OBJECT
    }
}
```

#### Example request

```javascript
{
    "data": {
        "package": {
            "age": 30,
            "salary": 4000,
            "loanType": "household",
            "loan": 30000
        }
    }
}
```
