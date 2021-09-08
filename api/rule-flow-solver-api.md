# Rule Flow Solver API

{% api-method method="post" host="https://api.decisionrules.io/" path="composition/solve/:ruleFlowId/:version" %}
{% api-method-summary %}

{% endapi-method-summary %}

{% api-method-description %}

{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="ruleFlowId" type="string" required=true %}
Unique identifier rule that is common to all versions
{% endapi-method-parameter %}

{% api-method-parameter name="version" type="integer" required=false %}
Business rule version. If the parameter is not filled in, the last published version will be used automatically.
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Authorization" type="string" required=true %}
Bearer &lt;Token&gt;
{% endapi-method-parameter %}

{% api-method-parameter name="Content-Type" type="string" required=true %}
aplication/json
{% endapi-method-parameter %}
{% endapi-method-headers %}

{% api-method-body-parameters %}
{% api-method-parameter name="data" type="object" required=true %}
JSON object that describes the input json data
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
[
  {
    "loan": 30000,
    "tax": 1.15,
    "message": "eligible for the loan"
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
        "message": "Unknown ruleFlow or version"
    }
}
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
https://api.decisionrules.io/compositin/solve/:ruleFlowId/:version

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



