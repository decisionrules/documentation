---
description: Request and response from API solving.
cover: >-
  https://images.unsplash.com/photo-1555066931-4365d14bab8c?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHw4fHxjb2RlfGVufDB8fHx8MTYzNjk4NjM4Mg&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Rule Solver API

The Rule Solver API is the most important API of DecisionRules. It allows you to send requests to solve rules (decision tables, decision trees, etc.) and obtain the output data. Below, you will find the specification of the single endpoint of this API.

{% hint style="success" %}
In version 1.16.0 and newer you can solve your ruleflow with **Rule Solver API** endpoint.

Rule flow Solver API endpoint is now depreated.
{% endhint %}

### Swagger

You can check out these endpoints and call them right away using swagger.

**Swagger UI:** [https://api.decisionrules.io/api/solver/docs](https://api.decisionrules.io/api/solver/docs/)

**Swagger JSON File:** [https://api.decisionrules.io/api/solver/docs/json](https://api.decisionrules.io/api/solver/docs/json)

### Solve Rule

This endpoint allows you to solve your rule while providing input data in JSON format.

## Solve Rule

<mark style="color:green;">`POST`</mark> `https://api.decisionrules.io/rule/solve/:ruleId/:version`

#### Path Parameters

| Name                                     | Type    | Description                                                                                                                              |
| ---------------------------------------- | ------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| ruleId<mark style="color:red;">\*</mark> | string  | Unique identifier rule that is common to all rule versions. Instead of rule ID, it is possible to use rule alias.                        |
| version                                  | integer | Business rule version. If the parameter is not filled in, the last published version will be used automatically. See more on versioning. |

#### Headers

| Name                                            | Type   | Description                                                                                                                                                                                                |
| ----------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer \<Solver API Key>                                                                                                                                                                                   |
| Content-Type                                    | string | application/json                                                                                                                                                                                           |
| X-Strategy                                      | string | <p>STANDARD or ARRAY or FIRST_MATCH.</p><p><a href="../other/execution-strategy.md">More in execution strategies</a></p>                                                                                   |
| X-Correlation-Id                                | string | Correlation ID, in case you would like to set it manually. If not present, correlation ID will be generated automatically. In any case, the correlation ID is returned in the same header of the response. |
| X-Audit                                         | string | Decides whether an audit of the solve should be created and saved. In case you want the audit to be created and saved, input "true".                                                                       |
| X-Audit-Ttl                                     | string | A number that dictates after how many days the audit will be deleted. Set to 14 days by default.                                                                                                           |
| X-Debug                                         | string | Allows to switch on the debug mode, which is by default off. Set this header to "true" if you want to activate it.                                                                                         |

#### Request Body

| Name    | Type   | Description                                     |
| ------- | ------ | ----------------------------------------------- |
| data    | object | JSON object that describes the input json data. |
| options | object | Object specifying solver options.               |

{% tabs %}
{% tab title="200 Rule Solved" %}
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
{% endtab %}

{% tab title="400 " %}
```
{
    "error": {
        "message": "Unknown rule or rule version"
    }
}
```
{% endtab %}

{% tab title="401 Could not find matching rule" %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
For easy Rule Solver API calls go to Integrations -> Code Library. Note that the cURL code can be copy/pasted directly to Postman.
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
If you're using the **Regional Cloud** version of DecisionRules, read more about API calls [here](../regional-cloud/region-specific-api-urls.md#making-api-calls-on-region-cloud-accounts).
{% endhint %}

{% hint style="info" %}
Note that you can use **rule alias** instead of rule ID to identify the rule. In that case, make sure that the rule alias is unique within the space, otherwise the request will fail.
{% endhint %}

{% hint style="info" %}
You must provide your own API Key after the `Bearer` keyword. Generate it in the [API Keys ](https://app.decisiongrid.io/api-keys)section of the app.
{% endhint %}

The body of the request needs to have the following structure.

```javascript
{
    "data": {
        // INPUT OBJECT
    }
}
```

For example, it may look as follows. Note that the object provided under the `data` key needs to correspond to the input model of the rule you wish to solve (see Rule Settings -> I/O Model).

```javascript
{
    "data": {
        "client": {
            "age": 18
        }
    }
}
```

### Simple Solve

Simple solve means that you send a single set of input data and the solver thus evaluates this single input. The response is an array of results (given e.g. by the individual rows of a decision table).

#### Rule

![](../.gitbook/assets/ima4ge.PNG)

#### Simple Request

This is how the object sent under the `data` key could look for the given rule.

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

#### Simple Response

And this would be the response. Suppose that only one row of the decision table was triggered and the output is therefore an array with a single output data object (corresponding to the outputs set on the triggered row).

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

### Bulk Solve

On the other hand, DecisionRules also supports the bulk solve, which is a call to the solver where you include multiple sets of input data. Each set is evaluated individually, with no relation to any other, and the solver returns an array of the corresponding output objects.

#### Rule

![](<../.gitbook/assets/image (176) (1).png>)

#### Bulk Request

This is how the JSON under the `data` key of a bulk request is structured. Instead of an input data object, you send an array of these objects.

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

#### Bulk Response

And here is the response. The outer array corresponds to the array provided in the bulk input. The inner arrays specify the individual results, just as in the case of a simple solve. Thus, in the following example, you can see two elements of the outer array corresponding to the two input data objects sent over in our bulk request (as seen above). Each of these elements is an array which holds a single result (therefore, a single row of the decision table was triggered for both sets of input data).

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

### Options

As you might have noticed, the body of the request to the Rule Solver API takes an optional `options` object. This object allows to configure the solver. In general, the options are different for each type of rule. As of now, they are only used for decision tables.

If you are solving a **decision table**, you may configure the solver with the following options.

#### Included Condition Cols

Allows to specify condition columns that should be taken in account when solving the decision table. All other columns will be ignored. Columns are identified by the name of the input variable related to the respective column.

For example, the body of the request may look like this.

```javascript
{
    "data": {
        // INPUT OBJECT
    },
    "options": {
        "includedConditionCols": ["client.age","portfolioAmount"]
    }
}
```

With this configuration, only the columns related to `client.age` and `portfolioAmount` input variables will be evaluated.

#### Excluded Condition Cols

If you wish to exclude some columns, you can do that with this property. Columns are identified by the name of the input variable related to the respective column.

{% hint style="info" %}
Note that the `includedConditionCols` take precedence over `excludedConditionCols`. If you specify both included and excluded condition columns, the excluded columns will be therefore ignored. It is recommended to use just one of these properties.
{% endhint %}

The body of the request may look as follows.

```javascript
{
    "data": {
        // INPUT OBJECT
    },
    "options": {
        "excludedConditionCols": ["client.age","portfolioAmount"]
    }
}
```

With this setup, all columns except the `client.age` and `portfolioAmount` will be considered when solving of the decision table.

As of now, there are no other **options** supported; in particular, there are no options that would affect other types of rules. However, it is expected that these will be added in the future with the evolving capabilities of DecisionRules.

