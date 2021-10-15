# Rule Flow Solver API

{% swagger baseUrl="https://api.decisionrules.io/" path="composition/solve/:ruleFlowId/:version" method="post" summary="RuleFlow Solver" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="ruleFlowId" type="string" %}
Unique RuleFlow ID that is same to all versions
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" %}
RuleFlow version. If the parameter is not filled in, the last published version will be used automatically.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" %}
Bearer <Token>
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Content-Type" type="string" %}
aplication/json
{% endswagger-parameter %}

{% swagger-parameter in="body" name="data" type="object" %}
JSON object that describes the input json data
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
Check [**geo-location**](geo-location.md) to make decisions even faster.
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

