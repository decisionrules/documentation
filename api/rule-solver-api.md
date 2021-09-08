---
description: Request and response from API solving.
---

# Rule Solver API

{% api-method method="post" host="https://api.decisionrules.io" path="/rule/solve/:ruleId/:version" %}
{% api-method-summary %}
Solve Rule
{% endapi-method-summary %}

{% api-method-description %}
This endpoint allows you to solve your decision table according to input JSON data.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="ruleId" type="string" required=true %}
Unique identifier rule that is common to all rule versions
{% endapi-method-parameter %}

{% api-method-parameter name="version" type="integer" required=false %}
Business rule version. If the parameter is not filled in, the last published version will be used automatically.  See more on versioning
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Authorization" type="string" required=true %}
Bearer &lt;Token&gt;
{% endapi-method-parameter %}

{% api-method-parameter name="Content-Type" type="string" required=true %}
application/json
{% endapi-method-parameter %}
{% endapi-method-headers %}

{% api-method-body-parameters %}
{% api-method-parameter name="data" type="object" required=true %}
JSON object that describes the input json data. 
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}
Rule Solved
{% endapi-method-response-example-description %}

```javascript
[
    {
        "car": {
            "price": "666666",
            "seats": {},
            "discount": {
                "low": "2",
                "high": "33"
            }
        }
    },
    {
        "car": {
            "price": "8888888",
            "seats": {},
            "discount": {
                "low": "8",
                "high": "33"
            }
        }
    }
]
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=400 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
{
    "error": {
        "message": "Unknown rule or rule version"
    }
}
```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=401 %}
{% api-method-response-example-description %}
Could not find matching rule
{% endapi-method-response-example-description %}

```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

{% api-method method="post" host="https://api.decisionrules.io" path="/rule/solve/:ruleId/:version" %}
{% api-method-summary %}

{% endapi-method-summary %}

{% api-method-description %}

{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="" type="string" required=false %}

{% endapi-method-parameter %}
{% endapi-method-path-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=400 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```

```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

{% hint style="info" %}
Check [**geo-location**](geo-location.md) to make decisions even faster.
{% endhint %}

#### Request example

```http
URL
https://api.decisionrules.io/rule/solve/:ruleId/:version

Headers:
Content-Type: application/json
Authorization: Bearer DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH
```

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
            "tariff": "basic",
            "distance": 82
        }
    }
}
```

