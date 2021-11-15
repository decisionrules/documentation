---
description: Request and response from API solving.
---

# Rule Solver API

{% swagger baseUrl="https://api.decisionrules.io" path="/rule/solve/:ruleId/:version" method="post" summary="Solve Rule" %}
{% swagger-description %}
This endpoint allows you to solve your decision table according to input JSON data.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" %}
Unique identifier rule that is common to all rule versions
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" %}
Business rule version. If the parameter is not filled in, the last published version will be used automatically.  See more on versioning
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" %}
Bearer <Token>
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Content-Type" type="string" %}
application/json
{% endswagger-parameter %}

{% swagger-parameter in="header" name="X-Strategy" type="string" %}
STANDARD or ARRAY or FIRST_MATCH
{% endswagger-parameter %}

{% swagger-parameter in="body" name="data" type="object" %}
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

{% hint style="info" %}
Check [**geo-location**](geo-location.md) to make decisions even faster.
{% endhint %}

{% hint style="info" %}
Check [**execution strategies**](../other/execution-strategy.md) to change solver output.
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

### Simple solve - example

#### Rule&#x20;

![](../.gitbook/assets/ima4ge.PNG)

#### Simple request&#x20;

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

### Bulk (array) solve - example

#### Rule

![](<../.gitbook/assets/image (148) (1).png>)

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
