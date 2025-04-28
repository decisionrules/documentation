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

## RuleFlow Solver

<mark style="color:green;">`POST`</mark> `https://api.decisionrules.io/composition/solve/:ruleFlowId/:version`

#### Path Parameters

| Name       | Type    | Description                                                                                                 |
| ---------- | ------- | ----------------------------------------------------------------------------------------------------------- |
| ruleFlowId | string  | Unique RuleFlow ID that is the same to all versions. You can also use the rule alias.                       |
| version    | integer | RuleFlow version. If the parameter is not filled in, the last published version will be used automatically. |

#### Headers

| Name          | Type   | Description                                                                                                                          |
| ------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| Authorization | string | Bearer                                                                                                                               |
| Content-Type  | string | application/json                                                                                                                     |
| X-Strategy    | string | STANDARD or ARRAY or FIRST\_MATCH                                                                                                    |
| X-Audit       | string | Decides whether an audit of the solve should be created and saved. In case you want the audit to be created and saved, input "true". |
| X-Audit-Ttl   | string | A number that dictates after how many days the audit will be deleted.                                                                |

#### Request Body

| Name | Type   | Description                                    |
| ---- | ------ | ---------------------------------------------- |
| data | object | JSON object that describes the input json data |

{% tabs %}
{% tab title="200 " %}
```
[
  {
    "loan": 30000,
    "tax": 1.15,
    "message": "eligible for the loan"
  }
]
```
{% endtab %}

{% tab title="400 " %}
```
{
    "error": {
        "message": "Unknown ruleFlow or version"
    }
}
```
{% endtab %}

{% tab title="401 " %}
```
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
If you're using the **Regional Cloud** version of DecisionRules, read more about API calls [here](../../other-deployment-options/regional-cloud/region-specific-api-urls.md#making-api-calls-on-region-cloud-accounts).
{% endhint %}

{% hint style="info" %}
See  [**execution strategies**](../../rules/common-rule-features/execution-strategy.md) to change solver output format.
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
