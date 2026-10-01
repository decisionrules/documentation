---
description: Solve a rule on Aero solver and get the result in the same call.
cover: >-
  https://images.unsplash.com/photo-1555066931-4365d14bab8c?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHw4fHxjb2RlfGVufDB8fHx8MTYzNjk4NjM4Mg&ixlib=rb-1.2.1&q=85
coverY: 0
layout:
  width: wide
  cover:
    visible: true
    size: full
    mask: none
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
  tags:
    visible: true
  actions:
    visible: true
  anchors:
    visible: true
---

# Rule Solver API v2

{% hint style="info" %}
Available for server versions ≥ 1.27.0
{% endhint %}

The Rule Solver API is the main way to evaluate your rules from your own application. You send the input data, and the rule — a Decision Table, Decision Tree, Decision Flow or any other rule type — returns its output in the same call.

This page describes version 2 of the API. It runs on **solver v2**, also called **Aero**, where all new features are released.&#x20;

{% hint style="info" %}
**Already calling the Rule Solver API?** \
If you use `/rule/solve/` or `/rule/v1/solve/`, see [Rule Solver API Migration](solver-version-migration.md).
{% endhint %}

{% hint style="success" %}
In version 1.16.0 and newer Rule Flows are solved with this endpoint too. The separate Rule Flow Solver API is deprecated.

**Note that Rule Flows are always evaluated by solver V1.** See [Exceptions](rule-solver-api.md#exceptions).
{% endhint %}

Below you will find the specification of this endpoint.

## Swagger

You can check out these endpoints and call them right away using swagger.

**Swagger UI:** [https://api.decisionrules.io/api/solver/docs](https://api.decisionrules.io/api/solver/docs/)

**Swagger JSON File:** [https://api.decisionrules.io/api/solver/docs/json](https://api.decisionrules.io/api/solver/docs/json)

{% openapi-operation spec="solver-api" path="/rule/v2/solve/{ruleId}/{ruleVersion}" method="post" %}
[OpenAPI solver-api](https://4401d86825a13bf607936cc3a9f3897a.r2.cloudflarestorage.com/gitbook-x-prod-openapi/raw/fef1df790a9b2afd67cdca40bf6d1ec2c25ffbc87622e4fd00441bdcdc93493c.yaml?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=dce48141f43c0191a2ad043a6888781c%2F20261001%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20261001T123357Z&X-Amz-Expires=172800&X-Amz-Signature=1013556d09606e4167d018df31b8f6106fd820577bc1d21b3acd10d5a9525d0c&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject)
{% endopenapi-operation %}

## Request example

```html
URL
https://api.decisionrules.io/rule/v2/solve/{ruleId}/{ruleVersion}

Headers:
Content-Type: application/json
Authorization: Bearer <YOUR_API_KEY>
```

`{ruleVersion}` is optional. Leave it out, as in `/rule/v2/solve/{ruleId}`, and the latest published version of the rule is used.

For easy Rule Solver API calls go to **Integrations → Code Samples**. Note that the cURL code can be copy/pasted directly to Postman.

<figure><img src="../../.gitbook/assets/Frame 69.png" alt=""><figcaption></figcaption></figure>

If you're using the Regional Cloud version of DecisionRules, read more about API calls [here](https://app.gitbook.com/s/dv9UprVu3KjO5la255ws/regional-cloud/region-specific-api-urls).

Note that you can use the rule alias instead of the rule ID to identify the rule. In that case, make sure that the rule alias is unique within the space, otherwise the request will fail.

You must provide your own API key after the `Bearer` keyword. Generate it in the [API Keys](../api-keys/) section of the app.

### **Body**

The body of the request needs to have the following structure.

```json
{
    "data": {
        // INPUT OBJECT
    }
}
```

For example, it may look as follows. The object under the `data` key needs to correspond to the input model of the rule you want to solve, see [I/O Model](../../rules/common-rule-features/input-and-output/).

```json
{
    "data": {
        "client": {
            "age": 18
        }
    }
}
```

If the input is not wrapped in `data`, the request is rejected with `400`. See [Invalid requests](rule-solver-api.md#invalid-requests).

{% hint style="warning" %}
**`data`** is part of the API request, not part of your rule. It is the envelope the Solver API expects, and it exists only here:

* **In the I/O Model**, define the fields of the input object itself — `client`, `age`, and so on. Do not add a `data` field to the model.
* **In Test Bench**, enter the input object itself, without the wrapper. Test Bench sends it for you.
{% endhint %}

### Options

The request body can contain an optional `options` object that configures how the rule is solved. Each option below says which rule types it applies to.

#### **Included Condition Cols**

**Decision Tables only.** Specifies the condition columns to evaluate; all other columns are ignored. Columns are identified by the name of the input variable related to the column.

```javascript
{
  "data": {
    "client": {
      "age": 18
    },
    "productCount": {
      "accountsAndCards": 4,
      "Investments": 4
    },
    "portfolioAmount": 15000
  },
  "options": {
    "includedConditionCols": ["client.age", "portfolioAmount"]
  }
}
```

With this configuration, only the columns related to `client.age` and `portfolioAmount` are evaluated. The columns for `productCount.accountsAndCards` and `productCount.Investments` are ignored, even though their values are sent.

#### **Excluded Condition Cols**

**Decision Tables only.** Specifies the condition columns to ignore. Columns are identified by the name of the input variable related to the column.

```javascript
{
  "data": {
    "client": {
      "age": 18
    },
    "productCount": {
      "accountsAndCards": 4,
      "Investments": 4
    },
    "portfolioAmount": 15000
  },
  "options": {
    "excludedConditionCols": ["client.age", "portfolioAmount"]
  }
}
```

With this setup, the columns related to `client.age` and `portfolioAmount` are ignored, and only the `productCount` columns are evaluated.

{% hint style="warning" %}
`includedConditionCols` takes precedence over `excludedConditionCols`. If you specify both, the excluded columns are ignored. We recommend using only one of them.
{% endhint %}

#### **Quit Solve On Fail**

Determines whether a failed HTTP function call stops the solve. Applies to HTTP functions used directly in the rule you call — in a Decision Table, Decision Tree or Decision Flow.

```javascript
{
  "data": {
    // INPUT OBJECT
  },
  "options": {
    "quitSolveOnFail": true
  }
}
```

When set to `true`, an error from an HTTP function — HTTP\_GET, HTTP\_POST, HTTP\_PUT, HTTP\_PATCH or HTTP\_DELETE — stops the solve, and the Rule Solver API returns an error response instead of 200. In Flows, errors from parallel branches and bulk executions stop the solve too.

When the option is omitted or set to `false`, a failed HTTP call does not stop the solve.

### Invalid requests

The solver checks the request before running the rule, and returns `400` with a message that says what is wrong:

| Request                                                  | Message                                                                          |
| -------------------------------------------------------- | -------------------------------------------------------------------------------- |
| Empty body or malformed JSON                             | `request body must be valid JSON`                                                |
| Input not wrapped in `data`, e.g. `{"creditScore": 700}` | `unexpected top-level field 'creditScore'; input data must be wrapped in "data"` |
| `data` is not an object, e.g. `{"data": "hello"}`        | `solve data must be an object or array of objects`                               |
| A bulk array with a non-object in it                     | `bulk solve data item 1 must be an object`                                       |
| `options` is not an object                               | `options must be an object`                                                      |

A rule that takes no input can be called with `{}`.

## Simple Solve

Simple solve means that you send a single set of input data and the solver thus evaluates this single input. The response is an array of results (given e.g. by the individual rows of a decision table).

<figure><img src="../../.gitbook/assets/Screenshot 2026-09-23 at 12.34.10.png" alt=""><figcaption></figcaption></figure>

### Simple Request

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

### Simple Response

And this would be the response. Only one row of the decision table was triggered, so the output is an array with a single object, holding the outputs set on that row.

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

## Bulk Solve

On the other hand, DecisionRules also supports the bulk solve, which is a call to the solver where you include multiple sets of input data. Each set is evaluated individually, with no relation to any other, and the solver returns an array of the corresponding output objects.

<figure><img src="../../.gitbook/assets/Screenshot 2026-09-23 at 12.33.44.png" alt=""><figcaption></figcaption></figure>

### Bulk Request

This is how the JSON under the `data` key of a bulk request is structured. Instead of an input data object, you send an array of these objects.

```json
[
  {                    // first input
    "product": { "id": "P1", "price": 400 },
    "paymentMethod": { "debitCard": true, "creditCard": false, "cash": {} }
  },
  {                    // second input
    "product": { "id": "P2", "price": 300 },
    "paymentMethod": { "debitCard": true, "creditCard": {}, "cash": {} }
  }
]
```

### Bulk Response

The outer array corresponds to the array sent in the request. Each inner array holds the results for one input, just as in a simple solve. In this example, one row of the decision table was triggered for each input.

```json
[
  [  // results for the first input
    {
      "suplier": "Amazon",
      "amount": 400
    }
  ],
  [  // results for the second input
    {
      "suplier": "Lenovo",
      "amount": 300
    }
  ]
]
```

## How the solver version is applied

Requests to this endpoint are evaluated by solver v2 (Aero). This section explains how to check which version evaluated a request, how the version carries over to the rules a rule calls, and the few cases where solver v1 is used instead.

### Response headers

Every response says which solver version evaluated the request, errors included:

```
X-Solver-Version: v2
X-Solver-Engine: aero
```

A response from solver v1 carries `v1` and `gaia`.

{% hint style="info" %}
The response also contains `X-Version`, and that is the version of **your rule**, not the solver.
{% endhint %}

### Rules that call other rules

When a rule calls another rule — from a flow node, a function or a script — the called rule runs on the same solver version. You choose the version once, in the call you make.

### Exceptions

[**Rule Flows**](../../rules/rule-flow/) and [**AI Agents**](../../rules/ai-agent/) are always evaluated by V1, whichever version you call.

You can still call these rules with any version. When you call one directly, the response header and the audit show `v1`, because that is the version that evaluated it.

{% hint style="info" %}
Inside a Decision Flow, only that node runs on V1. The rest of the flow runs on the version you called, and the response header shows that version.
{% endhint %}

