---
description: Request and response from API solving.
cover: >-
  https://images.unsplash.com/photo-1555066931-4365d14bab8c?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHw4fHxjb2RlfGVufDB8fHx8MTYzNjk4NjM4Mg&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Rule Solver API

## Rule Solver API endpoints

{% swagger baseUrl="https://api.decisionrules.io" path="/rule/solve/:ruleId/:version" method="post" summary="Solve Rule" %}
{% swagger-description %}
This endpoint allows you to solve your decision table according to input JSON data.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" required="false" %}
Unique identifier rule that is common to all rule versions
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" required="false" %}
Business rule version. If the parameter is not filled in, the last published version will be used automatically. See more on versioning
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="false" %}
Bearer
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Content-Type" type="string" required="false" %}
application/json
{% endswagger-parameter %}

{% swagger-parameter in="header" name="X-Strategy" type="string" required="false" %}
STANDARD or ARRAY or FIRST\_MATCH.

[More in execution strategies](../other/execution-strategy.md)
{% endswagger-parameter %}

{% swagger-parameter in="body" name="data" type="object" required="false" %}
JSON object that describes the input json data.
{% endswagger-parameter %}

{% swagger-response status="200" description="Rule Solved" %}
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
{% endswagger-response %}

{% swagger-response status="400" description="" %}
```
{
    "error": {
        "message": "Unknown rule or rule version"
    }
}
```
{% endswagger-response %}

{% swagger-response status="401" description="Could not find matching rule" %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endswagger-response %}
{% endswagger %}

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

### Example of simple solve

#### Rule

![](../.gitbook/assets/ima4ge.PNG)

#### Simple request

```json
{
  "client": {
    "age": 18
  },
  "productCount": {
    "accountsAndCards": 4,
    "Investments": 4
  },
  "portfolioAmount": 15000
}
```

#### Simple response

```json
[
  {
    "totalProducts": 8,
    "amountPerProduct": 1875,
    "client": {
      "segment": "senior affluent"
    },
    "profitability": 1
  }
]
```

### Example of bulk (array) solve

#### Rule

![](<../.gitbook/assets/image (148) (1) (1).png>)

#### Bulk request

```json
[
  {
    "product": {
      "id": "P1",
      "price": 400
    },
    "paymentMethod": {
      "debitCard": true,
      "creditCard": false,
      "cash": {}
    }
  },
  {
    "product": {
      "id": "P2",
      "price": 300
    },
    "paymentMethod": {
      "debitCard": true,
      "creditCard": {},
      "cash": {}
    }
  }
]
```

#### Bulk response

```json
[
  [
    {
      "suplier": "Amazon",
      "amount": 400
    }
  ],
  [
    {
      "suplier": "Lenovo",
      "amount": 300
    }
  ]
]
```
