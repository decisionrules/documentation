# Region Specific API URLs

## Making API calls on Region Cloud accounts

The process of calling the Rule Solver, Managment API or BI API is the same for region-locked accounts and Global Cloud accounts. The only difference is the endpoint URL.&#x20;

With the Regional Cloud accounts having to **prepend the URL with their respective regional shortcut.**

<table><thead><tr><th width="201">Location</th><th width="136.33333333333331" align="center">Shortcut</th><th align="right"> API call URL example</th></tr></thead><tbody><tr><td><img src="../../.gitbook/assets/image (190) (1) (1).png" alt=""> USA</td><td align="center">us</td><td align="right"><code>https://us.api.decisionrules.io/:PATH</code></td></tr><tr><td><img src="../../.gitbook/assets/european-union.png" alt="" data-size="line"> European Union</td><td align="center">eu</td><td align="right"><code>https://eu.api.decisionrules.io/:PATH</code></td></tr><tr><td><img src="../../.gitbook/assets/image (160) (1).png" alt=""> Australia</td><td align="center">au</td><td align="right"><code>https://au.api.decisionrules.io/:PATH</code></td></tr></tbody></table>

### A few examples

#### Solving a rule through the Solver API

Let's say you want to solve a rule on an account registered in the ![](<../../.gitbook/assets/image (190) (1) (1).png>)United States. We would follow the instructions in the [Rule Solver API article](../../api/rule-solver-api.md#solve-rule) and simply prepend the usual URL with our region's shortcut. In this case 'us', forming the following request:

## Solve Rule

<mark style="color:green;">`POST`</mark> `https://us.api.decisionrules.io/rule/solve/:ruleId/:version`

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
| X-Strategy                                      | string | <p>STANDARD or ARRAY or FIRST_MATCH.</p><p><a href="../../rules/common-rule-features/execution-strategy.md">More in execution strategies</a></p>                                                           |
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

### Updating a rule through the Managment API

Let's say you want to update a rule on an account registered in the <img src="../../.gitbook/assets/european-union.png" alt="" data-size="line">EU. We would follow the instructions in the [Management API article](../../api/management-api.md#update-rule) and simply prepend the usual URL with our region's shortcut. In this case 'eu', forming the following request:

## Update rule

<mark style="color:orange;">`PUT`</mark> `https://eu.api.decisionrules.io/api/rule/:ruleId/:version`

#### Path Parameters

| Name    | Type    | Description                                                                           |
| ------- | ------- | ------------------------------------------------------------------------------------- |
| rule Id | string  | Unique rule ID which is common to all rule versions. **You can also use rule alias.** |
| version | integer | Version of Rule                                                                       |

#### Headers

| Name          | Type   | Description |
| ------------- | ------ | ----------- |
| Authorization | string | Bearer      |

#### Request Body

| Name | Type   | Description           |
| ---- | ------ | --------------------- |
| body | object | JSON format of a rule |

{% tabs %}
{% tab title="200 The rule has been updated" %}
```
```
{% endtab %}

{% tab title="400 " %}
```
TypeError: rule.decisionTable.rows is not iterable
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

### Getting Console Logs for a rule solve through the Console Logs API

Let's say you want to get console logs for a rule solve on an account registered in ![](<../../.gitbook/assets/image (160) (1).png>)Australia. We would follow the instructions in the [Console Logs API article](../../api/console-logs-api.md#get-console-logs) and simply prepend the usual URL with our region's shortcut. In this case 'au', forming the following request:

## Get Console Logs for a solve

<mark style="color:blue;">`GET`</mark> `https://au.api.decisionrules.io/consoleLogs/:correlationId`

#### Query Parameters

| Name                                            | Type   | Description                     |
| ----------------------------------------------- | ------ | ------------------------------- |
| correlationId<mark style="color:red;">\*</mark> | String | CorrelationId of specific solve |

#### Headers

| Name                                            | Type   | Description              |
| ----------------------------------------------- | ------ | ------------------------ |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer \<Solver API Key> |
