---
description: >-
  The Management API is a secure REST API that provides read/write access to
  your rules and spaces.
cover: >-
  https://images.unsplash.com/photo-1623282033815-40b05d96c903?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwxfHxBUEl8ZW58MHx8fHwxNjM0NzM3NjYx&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Management API

API Request methods cheat sheet:&#x20;

{% hint style="info" %}
<mark style="color:blue;">GET</mark> - Used to **retrieve resource representation/information** and not modify it in any way, e.g., get a JSON representaition of a rule with the GET RULES endpoint.

<mark style="color:green;">POST</mark> -  Used to **create new subordinate resources**, e.g., creating a new rule in a Space or Importing a rule into a Space.

<mark style="color:orange;">PUT</mark> - Used primarily to **update an existing resource (if the resource does not exist, then API may decide to create a new resource or not),** e.g., updating a Rule Flow&#x20;

<mark style="color:orange;">PATCH</mark> - Used to **make a partial update** on a resource, e.g., add Tags to an existing rule.

<mark style="color:red;">DELETE</mark> - Used to **delete resources,** e.g., deleting rules.
{% endhint %}

{% hint style="success" %}
<mark style="background-color:green;">**NEW in v1.16.0!**</mark> The Management API now fully support use of Rule Aliases when making requests.
{% endhint %}

{% hint style="info" %}
If you're using the **Regional Cloud** version of DecisionRules, read more about API calls [here](../regional-cloud/region-specific-api-urls.md#making-api-calls-on-region-cloud-accounts).
{% endhint %}

## Swagger

You can check out these endpoints and call them right away using swagger.

**Swagger UI:** [https://api.decisionrules.io/api/docs/](https://api.decisionrules.io/api/docs/)

**Swagger JSON File:** [https://api.decisionrules.io/api/docs/json](https://api.decisionrules.io/api/docs/json)

## Folder Paths

{% hint style="success" %}
<mark style="background-color:green;">**NEW in v1.18.1**</mark> Some Management API Endpoints now support targetting by **Folder Path.**&#x20;
{% endhint %}

All Folder and select Rule endpoints now support targetting items by their folder path. Instead of having to provide the requests with Rule Aliases/IDs or Folder IDs users can now define the request target by leveraging the new **Folder Path functionality**.

#### Example:

To access **Calculation **<mark style="color:orange;">**v2**</mark> (see image below), instead of appending it's rule ID to the request as a parameter you can now specify the ?path= query parameter.&#x20;

<figure><img src="../.gitbook/assets/image (2) (1).png" alt=""><figcaption></figcaption></figure>

In this case to GET the rule the request would look like this:

```
https://api.decisionrules.io/api/rule?path=/Client/Important/Calculation&version=2
```

To access the entire "Important" Folder the request could now look like this:

```
https://api.decisionrules.io/api/folder?path=/Client/Important
```

{% hint style="warning" %}
* Request targets can be defined either by the ID **or** path, not both at the same time
* Folder Paths have to always begin with a slash "/"
* To target specific rule versions by path use the ?version= query parameter&#x20;
{% endhint %}

## Rules and Rule Flows

## Get rule

<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/rule/:ruleId/:version?`

Gets all of the infromation stored about the rule, including its content, version or input and output schemas.&#x20;

If the version is specified, gets the version irrespective of the rule status.

If the version is not specified, gets the **latest published** version.

{% hint style="info" %}
You can target the rule using [Folder Path](management-api.md#folder-paths) instead of the :ruleId and :version parameters.
{% endhint %}

#### Path Parameters

<table><thead><tr><th width="128">Name</th><th width="134">Type</th><th>Description</th></tr></thead><tbody><tr><td>ruleId</td><td>string</td><td>Unique rule ID or alias which is common to all rule versions.</td></tr><tr><td>version</td><td>integer</td><td>Business rule version.</td></tr></tbody></table>

#### Path Query Parameters

<table><thead><tr><th width="128">Name</th><th width="134">Type</th><th>Description</th></tr></thead><tbody><tr><td>path</td><td>string</td><td>Unique folder path leading to the rule.</td></tr><tr><td>version</td><td>integer</td><td>Business rule version.</td></tr></tbody></table>

#### Headers

<table><thead><tr><th>Name</th><th width="110">Type</th><th>Description</th></tr></thead><tbody><tr><td>Authorization<mark style="color:red;">*</mark></td><td>string</td><td>Bearer</td></tr><tr><td>Content-Type<mark style="color:red;">*</mark></td><td>string</td><td>application/json</td></tr></tbody></table>

{% tabs %}
{% tab title="200 " %}
```
{
  "name": "Rule Name",
  "description": "",
  "inputSchema": {
    "Input attribute": {}
  },
  "outputSchema": {
    "Output Attribute": {}
  },
  "decisionTable": {
    "columns": [
      {
        "condition": {
          "type": "simple",
          "inputVariable": "Input attribute",
          "name": "New Condition"
        },
        "columnId": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
        "type": "input"
      },
      {
        "columnOutput": {
          "type": "simple",
          "outputVariable": "Output Attribute",
          "name": "New Result"
        },
        "columnId": "2e46eb73-de05-51bc-5913-4b261bbe2069",
        "type": "output"
      }
    ],
    "rows": [
      {
        "cells": [
          {
            "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
            "scalarCondition": {
              "value": "",
              "operator": "anything"
            },
            "type": "input"
          },
          {
            "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
            "outputScalarValue": {
              "value": "Hello from Solver"
            },
            "type": "output"
          }
        ]
      }
    ]
  },
  "type": "decision-table",
  "status": "published",
  "ruleId": "4ea...",
  "version": 1,
  "createdIn": "2021-09-03T06:35:42.663Z",
  "lastUpdate": "2021-09-03T06:35:42.663Z",
  "tags": ["tagName", "anotherTagName"]
}
```
{% endtab %}

{% tab title="400 " %}
```
Error: This rule belongs to another user OR rule not found
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

#### Path Parameters

| Name                                     | Type    | Description  |
| ---------------------------------------- | ------- | ------------ |
| ruleId<mark style="color:red;">\*</mark> | string  | gM6RzkIZ2Yoa |
| version                                  | integer | kwk9EqWFZN7S |

#### Headers

| Name                                            | Type   | Description  |
| ----------------------------------------------- | ------ | ------------ |
| Authorization<mark style="color:red;">\*</mark> | string | LgWcKwwM0JXy |
| Content-Type<mark style="color:red;">\*</mark>  | string | RycZjvfN2via |

{% hint style="info" %}
Get rule might be useful when you wish to create a new version of a rule. To do so you may <mark style="color:blue;">GET</mark> the rule, manually change the `"version"`attribute of the returned JSON object and then use said object with the <mark style="color:green;">POST</mark> Create rule method. This will result in a new version of the rule being created.
{% endhint %}

## Update rule status

<mark style="color:orange;">`PUT`</mark> `https://api.decisionrules.io/api/rule/status/:ruleId/:status/:version?`

Changes rule status from <mark style="color:orange;">pending</mark> to <mark style="color:green;">published</mark> and vice versa. If the version is not specified, the latest version will be used.

#### Path Parameters

| Name                                     | Type   | Description                                                                                |
| ---------------------------------------- | ------ | ------------------------------------------------------------------------------------------ |
| ruleId<mark style="color:red;">\*</mark> | String | Unique rule ID or alias which is common to all rule versions.                              |
| status<mark style="color:red;">\*</mark> | String | <mark style="color:orange;">pending</mark> XOR <mark style="color:green;">published</mark> |
| version                                  | Number | rule version                                                                               |

#### Headers

| Name                                            | Type   | Description                 |
| ----------------------------------------------- | ------ | --------------------------- |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer MANAGEMENT\_API\_KEY |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json            |

{% tabs %}
{% tab title="200: OK Status has been successfully updated " %}
Returns updated rule.
{% endtab %}

{% tab title="400: Bad Request One or more PATH parameters are invalid" %}
```javascript
{
    // Response
}
```
{% endtab %}
{% endtabs %}

## Update rule

<mark style="color:orange;">`PUT`</mark> `https://api.decisionrules.io/api/rule/:ruleId/:version`

Changes the rule according to the body of the request.

{% hint style="info" %}
You can target the rule using [Folder Path](management-api.md#folder-paths) instead of the :ruleId and :version parameters.
{% endhint %}

#### Path Parameters

| Name    | Type    | Description                                                   |
| ------- | ------- | ------------------------------------------------------------- |
| ruleId  | string  | Unique rule ID or alias which is common to all rule versions. |
| version | integer | Version of Rule                                               |

#### Path Query Parameters

<table><thead><tr><th width="128">Name</th><th width="134">Type</th><th>Description</th></tr></thead><tbody><tr><td>path</td><td>string</td><td>Unique folder path leading to the rule.</td></tr><tr><td>version</td><td>integer</td><td>Business rule version.</td></tr></tbody></table>

#### Headers

| Name                                            | Type   | Description      |
| ----------------------------------------------- | ------ | ---------------- |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer           |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json |

#### Request Body

| Name                                   | Type   | Description                    |
| -------------------------------------- | ------ | ------------------------------ |
| body<mark style="color:red;">\*</mark> | object | A complete rule in JSON format |

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

#### Path Parameters

| Name                                      | Type    | Description  |
| ----------------------------------------- | ------- | ------------ |
| ruleId<mark style="color:red;">\*</mark>  | string  | 9yrSPizz7lb5 |
| version<mark style="color:red;">\*</mark> | integer | TJzLrOP1EINh |

#### Headers

| Name                                            | Type   | Description  |
| ----------------------------------------------- | ------ | ------------ |
| Authorization<mark style="color:red;">\*</mark> | string | 6M4q9gDafPGp |
| Content-Type<mark style="color:red;">\*</mark>  | String | OpsT3twTFJRe |

#### Request Body

| Name                                   | Type   | Description  |
| -------------------------------------- | ------ | ------------ |
| body<mark style="color:red;">\*</mark> | object | wo4gaGQFjC7p |

{% hint style="info" %}
Update rule might be useful when renaming a rule. First <mark style="color:blue;">GET</mark> the rule you wish to rename, change the`name`attribute of the returned JSON object and then use <mark style="color:orange;">PUT</mark> Update rule with the changed JSON object.
{% endhint %}

Note that there are a few attributes of the rule that cannot be updated by the <mark style="color:orange;">`PUT`</mark> endpoint. Namely, you cannot use <mark style="color:orange;">`PUT`</mark> to change the rule ID, version and rule alias. Also, you cannot change the date of last update, since it gets updated automatically.

## Create rule

<mark style="color:green;">`POST`</mark> `https://api.decisionrules.io/api/rule`

Creates rule based on the body of the request. The body must be formatted according to the example below.

{% hint style="info" %}
You can create the rule in a specific folder by utilizing [Folder Path](management-api.md#folder-paths).
{% endhint %}

#### Path Query Parameters

<table><thead><tr><th width="128">Name</th><th width="134">Type</th><th>Description</th></tr></thead><tbody><tr><td>path</td><td>string</td><td>Unique folder path leading to the rule.</td></tr><tr><td>version</td><td>integer</td><td>Business rule version.</td></tr></tbody></table>

#### Headers

| Name                                            | Type   | Description                    |
| ----------------------------------------------- | ------ | ------------------------------ |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer \<MANAGEMENT\_API\_KEY> |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json               |

{% tabs %}
{% tab title="200 Change has been made" %}
```
```
{% endtab %}

{% tab title="400 Invalid API key or ruleId" %}
```
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

#### Request body example

This example serves as a template for request bodies when creating rules with <mark style="color:green;">POST</mark> Create rule.

When updating rules with <mark style="color:orange;">PUT</mark> Update rule, the body of the request must have the same format as well.&#x20;

<details>

<summary>body example</summary>

```json
{
    "name": "Test from Tutorial",
    "description": "",
    "inputSchema": {
        "Input attribute": {}
    },
    "outputSchema": {
        "Output Attribute": {}
    },
    "decisionTable": {
        "columns": [
            {
                "condition": {
                    "type": "simple",
                    "inputVariable": "Input attribute",
                    "name": "New Condition"
                },
                "columnId": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                "type": "input"
            },
            {
                "columnOutput": {
                    "type": "simple",
                    "outputVariable": "Output Attribute",
                    "name": "New Result"
                },
                "columnId": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                "type": "output"
            }
        ],
        "rows": [
            {
                "cells": [
                    {
                        "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                        "scalarCondition": {
                            "value": "",
                            "operator": "anything"
                        },
                        "type": "input"
                    },
                    {
                        "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                        "outputScalarValue": {
                            "value": "Hello from Tutorial"
                        },
                        "type": "output"
                    }
                ],
                "active": true
            }
        ]
    },
    "type": "decision-table",
    "status": "published",
    "createdIn": "2021-09-08T11:40:32.542Z",
    "lastUpdate": "2021-09-08T11:40:59.398Z",
    "tags": ["tagName"]
}
```

</details>

## Delete rule

<mark style="color:red;">`DELETE`</mark> `https://api.decisionrules.io/api/rule/:ruleId/:version`

Deletes the rule.

{% hint style="info" %}
You can target the rule using [Folder Path](management-api.md#folder-paths) instead of the :ruleId and :version parameters.
{% endhint %}

#### Path Parameters

| Name                                     | Type    | Description                                                      |
| ---------------------------------------- | ------- | ---------------------------------------------------------------- |
| ruleId<mark style="color:red;">\*</mark> | string  | Unique rule ID or alias which is common to all rule versions.    |
| version                                  | integer | Version of Rule. If not specified, all versions will be deleted! |

#### Path Query Parameters

<table><thead><tr><th width="128">Name</th><th width="134">Type</th><th>Description</th></tr></thead><tbody><tr><td>path</td><td>string</td><td>Unique folder path leading to the rule.</td></tr><tr><td>version</td><td>integer</td><td>Business rule version.</td></tr></tbody></table>

#### Headers

| Name                                            | Type   | Description      |
| ----------------------------------------------- | ------ | ---------------- |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer           |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json |

{% tabs %}
{% tab title="200 " %}
```
```
{% endtab %}

{% tab title="400 Invalid API key or ruleId" %}
```
Error: This rule belongs to another user OR rule not found
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

#### Path Parameters

| Name                                     | Type    | Description  |
| ---------------------------------------- | ------- | ------------ |
| ruleId<mark style="color:red;">\*</mark> | string  | CfMUHelZSIU2 |
| version                                  | integer | zwf3bIA5cDgU |

#### Headers

| Name                                            | Type   | Description  |
| ----------------------------------------------- | ------ | ------------ |
| Authorization<mark style="color:red;">\*</mark> | string | kBQr0rNvibyK |
| Content-Type<mark style="color:red;">\*</mark>  | String | T9sgNzzO4IF2 |

{% hint style="warning" %}
If you do not specify version of the rule to be deleted, the endpoint will delete **all versions of the rule**. Please, use it with caution! Once deleted, rules cannot be recovered.
{% endhint %}



## Lock rule

<mark style="color:purple;">`PATCH`</mark> `https://api.decisionrules.io/api/lock/:ruleId/:version`

Locks / Unlocks the rule.

{% hint style="info" %}
You can target the rule using [Folder Path](management-api.md#folder-paths) instead of the :ruleId and :version parameters.
{% endhint %}

#### Path Parameters

| Name    | Type    | Description                                                   |
| ------- | ------- | ------------------------------------------------------------- |
| ruleId  | string  | Unique rule ID or alias which is common to all rule versions. |
| version | integer | Version of Rule.                                              |

#### Path Query Parameters

<table><thead><tr><th width="128">Name</th><th width="134">Type</th><th>Description</th></tr></thead><tbody><tr><td>path</td><td>string</td><td>Unique folder path leading to the rule.</td></tr><tr><td>version</td><td>integer</td><td>Business rule version.</td></tr></tbody></table>

####

Headers

| Name                                            | Type   | Description      |
| ----------------------------------------------- | ------ | ---------------- |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer           |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json |

<details>

<summary>Body example</summary>

```json
{
    "locked": true | false
}
```

</details>

### Export Rule Flow with all rules

{% tabs %}
{% tab title="200 " %}
```
```
{% endtab %}

{% tab title="400 Invalid API key, ruleId or version" %}
```
Error: Version is mandatory
OR
Error: Locked property incorrectly specified
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



<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/rule-flow/export/:ruleFlowId/:version?`

Export Rule Flow with all rules. If the version is not specified, export Rule Flow with the latest version.

#### Path Parameters

| Name                                         | Type   | Description                                                   |
| -------------------------------------------- | ------ | ------------------------------------------------------------- |
| ruleFlowId<mark style="color:red;">\*</mark> | String | Unique rule flow ID or alias which is common to all versions. |
| version                                      | Number |                                                               |

#### Headers

| Name                                            | Type   | Description      |
| ----------------------------------------------- | ------ | ---------------- |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer           |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json |

{% tabs %}
{% tab title="200: OK OK" %}
```javascript
[
  {
    "_id": "62627b2ac0fc11362331185e",
    "name": "Sample Rule Flow",
    "description": "This is sample description",
    "inputSchema": {
      "period": {},
      "productType": {},
      "promoCode": {}
    },
    "outputSchema": {
      "finalPrice": {},
      "crudePrice": {},
      "message": {}
    },
    "type": "composition",
    "status": "pending",
    "visualEditorData": {
      "drawflow": {
        "Home": {
          "data": {
            "1": {
              "id": 1,
              "data": {
                "type": "start"
              },
              "inputs": {},
              "outputs": {
                "output_1": {
                  "connections": [
                    {
                      "node": "2",
                      "output": "input_1"
                    }
                  ]
                }
              },
              "pos_x": 57,
              "pos_y": 218
            },
            "2": {
              "id": 2,
              "data": {
                "type": "node",
                "baseId": "f36bf7cf-bef4-1f4c-d756-c0b6f2f814ff",
                "globalVariable": "Rule_1"
              },
              "inputs": {
                "input_1": {
                  "connections": [
                    {
                      "node": "1",
                      "input": "output_1"
                    }
                  ]
                }
              },
              "outputs": {
                "output_1": {
                  "connections": [
                    {
                      "node": "3",
                      "output": "input_1"
                    }
                  ]
                }
              },
              "pos_x": 400,
              "pos_y": 150
            },
            "3": {
              "id": 3,
              "data": {
                "type": "end"
              },
              "inputs": {
                "input_1": {
                  "connections": [
                    {
                      "node": "2",
                      "input": "output_1"
                    }
                  ]
                }
              },
              "outputs": {},
              "pos_x": 785,
              "pos_y": 212
            }
          }
        }
      }
    },
    "dataTree": {
      "children": [
        {
          "baseId": "f36bf7cf-bef4-1f4c-d756-c0b6f2f814ff",
          "children": [
            {
              "children": [
                null
              ],
              "globalVariable": "end",
              "mapping": [
                {
                  "key": "finalPrice",
                  "source": "Rule_1",
                  "sourceVariable": "prices.finalPrice"
                },
                {
                  "key": "crudePrice",
                  "source": "Rule_1",
                  "sourceVariable": "prices.crudePrice"
                },
                {
                  "key": "message",
                  "source": "Rule_1",
                  "sourceVariable": "message"
                }
              ]
            }
          ],
          "globalVariable": "Rule_1",
          "mapping": [
            {
              "key": "period",
              "source": "start",
              "sourceVariable": "period"
            },
            {
              "key": "productType",
              "source": "start",
              "sourceVariable": "productType"
            },
            {
              "key": "promoCode",
              "source": "start",
              "sourceVariable": "promoCode"
            }
          ]
        }
      ],
      "globalVariable": "start",
      "mapping": []
    },
    "compositionId": "94c5ef08-d609-ef88-066a-fbeda7d1e537",
    "version": 1,
    "createdIn": "2022-04-22T09:53:46.744Z",
    "lastUpdate": "2022-04-22T09:53:46.744Z"
  },
  {
    "_id": "62627b2ac0fc11362331185d",
    "name": "Sample Rule Flow",
    "description": "This rule is a part of Sample Rule Flow.",
    "inputSchema": {
      "period": {},
      "productType": {},
      "promoCode": {}
    },
    "outputSchema": {
      "prices": {
        "finalPrice": {},
        "crudePrice": {}
      },
      "message": {}
    },
    "decisionTable": {
      "columns": [
        {
          "condition": {
            "type": "simple",
            "inputVariable": "productType",
            "name": "Product type"
          },
          "columnId": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
          "type": "input"
        },
        {
          "condition": {
            "type": "simple",
            "inputVariable": "period",
            "name": "Subscription period"
          },
          "columnId": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
          "type": "input"
        },
        {
          "condition": {
            "type": "simple",
            "inputVariable": "promoCode",
            "name": "New Condition"
          },
          "columnId": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
          "type": "input"
        },
        {
          "columnOutput": {
            "type": "simple",
            "outputVariable": "prices.crudePrice",
            "name": "Price without discounts"
          },
          "columnId": "2e46eb73-de05-51bc-5913-4b261bbe2069",
          "type": "output"
        },
        {
          "columnOutput": {
            "type": "simple",
            "outputVariable": "prices.finalPrice",
            "name": "Final price"
          },
          "columnId": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
          "type": "output"
        },
        {
          "columnOutput": {
            "type": "simple",
            "outputVariable": "message",
            "name": "New Result"
          },
          "columnId": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
          "type": "output"
        }
      ],
      "rows": [
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "basic",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "=",
                "value": "{PromoCode}",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "type": "common",
                "value": "8"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "basic",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "<>",
                "value": "{PromoCode}",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "type": "common",
                "value": "8"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "basic",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "=",
                "value": "{PromoCode}",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "type": "function",
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    6,
                    12
                  ]
                }
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "basic",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "<>",
                "value": "{PromoCode}",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "type": "function",
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    6,
                    12
                  ]
                }
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "medium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "IN",
                "value": [
                  "{PromoCode}",
                  "BUSINESS SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": "15",
                "type": "common"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "medium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "NOT IN",
                "value": [
                  "{PromoCode}",
                  "BUSINESS SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": "15",
                "type": "common"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "medium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "IN",
                "value": [
                  "{PromoCode}",
                  "BUSINESS SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    12,
                    12
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "medium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "NOT IN",
                "value": [
                  "{PromoCode}",
                  "BUSINESS SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    12,
                    12
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "premium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "IN",
                "value": [
                  "{PromoCode}",
                  "DIAMOND SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": "25",
                "type": "common"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "premium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "NOT IN",
                "value": [
                  "{PromoCode}",
                  "DIAMOND SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": "25",
                "type": "common"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "premium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "IN",
                "value": [
                  "{PromoCode}",
                  "DIAMOND SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    21,
                    12
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "premium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "NOT IN",
                "value": [
                  "{PromoCode}",
                  "DIAMOND SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    21,
                    12
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        }
      ]
    },
    "type": "decision-table",
    "status": "published",
    "tags": [],
    "userVariables": [
      {
        "name": "PromoCode",
        "value": "SUMMER SALE",
        "saved": true,
        "editMode": true
      },
      {
        "name": "PromoDiscount",
        "value": 30,
        "saved": true,
        "editMode": true
      },
      {}
    ],
    "ruleId": "f36bf7cf-bef4-1f4c-d756-c0b6f2f814ff",
    "version": 1,
    "createdIn": "2022-04-22T09:53:46.586Z",
    "lastUpdate": "2022-04-22T09:53:46.586Z"
  }
]
```
{% endtab %}

{% tab title="400: Bad Request Invalid API key or ruleFlowId" %}
```javascript
{
  "error": {
    "message": "Invalid API key"
  }
}
```
{% endtab %}

{% tab title="426: Upgrade Required Operation not allowed" %}
```javascript
{
    // Response
}
```
{% endtab %}
{% endtabs %}

### Import Rule Flow with all rules

<mark style="color:green;">`POST`</mark> `https://api.decisionrules.io/api/rule-flow/import`

Import Rule Flow with all rules. If no query parameters are set, a new Rule Flow will be created. If the `new-version` and `version` query parameter are set, a new version of the targeted Rule Flow will be created. If the `overwrite` and `version` query parameters are set, a specific version of the target rule flow will be overwritten.

#### Query Parameters

| Name        | Type   | Description                          |
| ----------- | ------ | ------------------------------------ |
| new-version | String | ID or alias of the target Rule Flow. |
| overwrite   | String | ID or alias of the target Rule Flow. |
| version     | Number | Version of target Rule Flow          |

#### Headers

| Name                                            | Type   | Description      |
| ----------------------------------------------- | ------ | ---------------- |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer           |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json |

{% tabs %}
{% tab title="200: OK " %}
```javascript
{
  "_id": "62627b2ac0fc11362331185e",
  "name": "Sample Rule Flow",
  "description": "This is sample description",
  "inputSchema": {
    "period": {},
    "productType": {},
    "promoCode": {}
  },
  "outputSchema": {
    "finalPrice": {},
    "crudePrice": {},
    "message": {}
  },
  "type": "composition",
  "status": "pending",
  "visualEditorData": {
    "drawflow": {
      "Home": {
        "data": {
          "1": {
            "id": 1,
            "data": {
              "type": "start"
            },
            "inputs": {},
            "outputs": {
              "output_1": {
                "connections": [
                  {
                    "node": "2",
                    "output": "input_1"
                  }
                ]
              }
            },
            "pos_x": 57,
            "pos_y": 218
          },
          "2": {
            "id": 2,
            "data": {
              "type": "node",
              "baseId": "f36bf7cf-bef4-1f4c-d756-c0b6f2f814ff",
              "globalVariable": "Rule_1"
            },
            "inputs": {
              "input_1": {
                "connections": [
                  {
                    "node": "1",
                    "input": "output_1"
                  }
                ]
              }
            },
            "outputs": {
              "output_1": {
                "connections": [
                  {
                    "node": "3",
                    "output": "input_1"
                  }
                ]
              }
            },
            "pos_x": 400,
            "pos_y": 150
          },
          "3": {
            "id": 3,
            "data": {
              "type": "end"
            },
            "inputs": {
              "input_1": {
                "connections": [
                  {
                    "node": "2",
                    "input": "output_1"
                  }
                ]
              }
            },
            "outputs": {},
            "pos_x": 785,
            "pos_y": 212
          }
        }
      }
    }
  },
  "dataTree": {
    "children": [
      {
        "baseId": "f36bf7cf-bef4-1f4c-d756-c0b6f2f814ff",
        "children": [
          {
            "children": [
              null
            ],
            "globalVariable": "end",
            "mapping": [
              {
                "key": "finalPrice",
                "source": "Rule_1",
                "sourceVariable": "prices.finalPrice"
              },
              {
                "key": "crudePrice",
                "source": "Rule_1",
                "sourceVariable": "prices.crudePrice"
              },
              {
                "key": "message",
                "source": "Rule_1",
                "sourceVariable": "message"
              }
            ]
          }
        ],
        "globalVariable": "Rule_1",
        "mapping": [
          {
            "key": "period",
            "source": "start",
            "sourceVariable": "period"
          },
          {
            "key": "productType",
            "source": "start",
            "sourceVariable": "productType"
          },
          {
            "key": "promoCode",
            "source": "start",
            "sourceVariable": "promoCode"
          }
        ]
      }
    ],
    "globalVariable": "start",
    "mapping": []
  },
  "compositionId": "94c5ef08-d609-ef88-066a-fbeda7d1e537",
  "version": 1,
  "createdIn": "2022-04-22T09:53:46.744Z",
  "lastUpdate": "2022-04-22T09:53:46.744Z"
}
```
{% endtab %}

{% tab title="400: Bad Request Invalid API key" %}
```javascript
{
  "error": {
    "message": "Invalid API key"
  }
}
```
{% endtab %}

{% tab title="406: Not Acceptable Wrong Rule Flow format" %}
```javascript
{
    Error: Rule Flow is missing the property 'name'!
}
```
{% endtab %}

{% tab title="426: Upgrade Required Operation not allowed" %}
```javascript
{
    // Response
}
```
{% endtab %}
{% endtabs %}

#### Request example

{% file src="../.gitbook/assets/Import-RuleFlow-example.json" %}

## Spaces

### Gets all types of rules and ruleflows in space

<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/space/items`

The desired space is determined by Management API Key. This endpoint also gets set of rules used in every ruleflow.

#### Headers

| Name                                           | Type   | Description        |
| ---------------------------------------------- | ------ | ------------------ |
| Authorizaion<mark style="color:red;">\*</mark> | String | Bearer \<API\_KEY> |
| Content-Type                                   | String | application/json   |

{% tabs %}
{% tab title="200: OK " %}
```javascript
[
  {
        "baseId": "009d9438-59fc-1531-50c5-76fb4741aaca",
        "version": 1,
        "name": "Client Profitability (Sample Rule)",
        "status": "published",
        "type": "decision-table",
        "tags": [],
        "description": "Sample client profitability rule",
        "lastUpdate": "2022-02-21T14:10:33.581Z"
    },
    {
        "baseId": "00941c5a-7d21-d332-7cbf-a4f742556a85",
        "version": 1,
        "name": "Decision Tree",
        "status": "published",
        "type": "decision-tree",
        "tags": [],
        "description": "",
        "lastUpdate": "2022-03-24T09:52:43.548Z"
    },
    {
        "baseId": "b7b3f52a-52f1-4b04-59ff-548bf063221b",
        "version": 1,
        "name": "Sample Rule Flow",
        "status": "pending",
        "type": "composition",
        "tags": [],
        "description": "This is sample description",
        "lastUpdate": "2021-11-14T08:43:22.611Z",
        "rules": [
            {
                "id": "e72a23a2-0838-c52b-a284-baac28bc41b8"
            }
        ]
    },
]
```
{% endtab %}

{% tab title="400: Bad Request " %}
```javascript
{
    // Response
}
```
{% endtab %}

{% tab title="401: Unauthorized " %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endtab %}
{% endtabs %}

#### Headers

| Name                                           | Type   | Description  |
| ---------------------------------------------- | ------ | ------------ |
| Authorizaion<mark style="color:red;">\*</mark> | String | lf2RvZVYAbHB |
| Content-Type                                   | String | jRB25nYzcToa |

## Tags

### Get Rules/Rule Flows by tags

<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/tags/items`

This endpoint allows you to get all rules/rule flows with certain tags. Desired space is derived from Management API Key.

#### Query Parameters

| Name                                   | Type   | Description                                                                                                                                                                                    |
| -------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| tags<mark style="color:red;">\*</mark> | string | Comma separated list of tags. The query at the end of the url address should look like this: ?tags=tag1,tag2. Such query would select all the rules where tag array contains both tag1 and tag |

#### Headers

| Name                                            | Type   | Description        |
| ----------------------------------------------- | ------ | ------------------ |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer \<API\_KEY> |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json   |

{% tabs %}
{% tab title="200: OK Returns an array of rules and rule flows." %}
```json
[
{
  "name": "Rule Name",
  "description": "",
  "inputSchema": {
    "Input attribute": {}
  },
  "outputSchema": {
    "Output Attribute": {}
  },
  "decisionTable": {
    "columns": [
      {
        "condition": {
          "type": "simple",
          "inputVariable": "Input attribute",
          "name": "New Condition"
        },
        "columnId": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
        "type": "input"
      },
      {
        "columnOutput": {
          "type": "simple",
          "outputVariable": "Output Attribute",
          "name": "New Result"
        },
        "columnId": "2e46eb73-de05-51bc-5913-4b261bbe2069",
        "type": "output"
      }
    ],
    "rows": [
      {
        "cells": [
          {
            "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
            "scalarCondition": {
              "value": "",
              "operator": "anything"
            },
            "type": "input"
          },
          {
            "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
            "outputScalarValue": {
              "value": "Hello from Solver"
            },
            "type": "output"
          }
        ]
      }
    ]
  },
  "type": "decision-table",
  "status": "published",
  "ruleId": "4ea...",
  "version": 1,
  "createdIn": "2021-09-03T06:35:42.663Z",
  "lastUpdate": "2021-09-03T06:35:42.663Z",
  "tags": ["tag1", "tag2"]
},
{
  "name": "Rule Name",
  "description": "",
  "inputSchema": {
    "Input attribute": {}
  },
  "outputSchema": {
    "Output Attribute": {}
  },
  "decisionTable": {
    "columns": [
      {
        "condition": {
          "type": "simple",
          "inputVariable": "Input attribute",
          "name": "New Condition"
        },
        "columnId": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
        "type": "input"
      },
      {
        "columnOutput": {
          "type": "simple",
          "outputVariable": "Output Attribute",
          "name": "New Result"
        },
        "columnId": "2e46eb73-de05-51bc-5913-4b261bbe2069",
        "type": "output"
      }
    ],
    "rows": [
      {
        "cells": [
          {
            "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
            "scalarCondition": {
              "value": "",
              "operator": "anything"
            },
            "type": "input"
          },
          {
            "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
            "outputScalarValue": {
              "value": "Hello from Solver"
            },
            "type": "output"
          }
        ]
      }
    ]
  },
  "type": "decision-table",
  "status": "published",
  "ruleId": "4ea...",
  "version": 2,
  "createdIn": "2021-09-03T06:35:42.663Z",
  "lastUpdate": "2021-09-03T06:35:42.663Z",
  "tags": ["tag1", "tag2"]
}
]
```
{% endtab %}

{% tab title="400: Bad Request Invalid API key or no query added." %}
```javascript
{
    "error": {
        "message": "Invalid API key"
    }
}
```
{% endtab %}

{% tab title="401: Unauthorized Missing API key." %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endtab %}
{% endtabs %}

### Add tags to Rule/Rule Flow

<mark style="color:purple;">`PATCH`</mark> `https://api.decisionrules.io/api/tags/:id/:version?`

If you specify the version, the tag/tags will be added to the specified version. If the version is not specified, the tag/tags will be added to all the versions with given ID.

#### Path Parameters

| Name                                 | Type   | Description                                                                                    |
| ------------------------------------ | ------ | ---------------------------------------------------------------------------------------------- |
| id<mark style="color:red;">\*</mark> | string | Unique rule ID or alias which is common to all rule versions. **You can also use rule alias.** |
| version                              | string | version of Rule/Rule Flow                                                                      |

#### Headers

| Name                                            | Type   | Description        |
| ----------------------------------------------- | ------ | ------------------ |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer \<API\_KEY> |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json   |

#### Request Body

| Name                                   | Type  | Description                        |
| -------------------------------------- | ----- | ---------------------------------- |
| body<mark style="color:red;">\*</mark> | array | array of tags to add i JSON format |

{% tabs %}
{% tab title="200: OK Added successfully" %}
```javascript
{message: "ok"}
```
{% endtab %}

{% tab title="400: Bad Request Invalid API key or no tag array provided" %}
```javascript
{
    "error": {
        "message": "Invalid API key"
    }
}
```
{% endtab %}

{% tab title="401: Unauthorized Missing API key" %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endtab %}
{% endtabs %}

<details>

<summary>Patch request body example</summary>

{% code fullWidth="true" %}
```json
[
        {
                "tagName": "yourTagName",
                "color": "green"
        }
]

// tagName is required
// No special characters other than: "()?!_.: -" are allowed

// color is optional
// you can select one of these colors: gray, violet, yellow, green, red, white
// if you don't input color field, default color will be inserted automatically
```
{% endcode %}

</details>

### Delete tags from Rule/Rule Flow

<mark style="color:red;">`DELETE`</mark> `https://api.decisionrules.io/api/tags/:id/:version?`

If you specify the version, the tag/tags will be deleted from the specified version. If the version is not specified, the tag/tags will be deleted from all the versions with given ID.

#### Path Parameters

| Name                                 | Type   | Description                                                                                    |
| ------------------------------------ | ------ | ---------------------------------------------------------------------------------------------- |
| id<mark style="color:red;">\*</mark> | string | Unique rule ID or alias which is common to all rule versions. **You can also use rule alias.** |
| version                              | string | version of Rule/Rule Flow                                                                      |

#### Query Parameters

| Name                                   | Type   | Description                                                                                                  |
| -------------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------ |
| tags<mark style="color:red;">\*</mark> | string | Comma separated list of tags. The query at the end of the url address should look like this: ?tags=tag1,tag2 |

#### Headers

| Name                                            | Type   | Description        |
| ----------------------------------------------- | ------ | ------------------ |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer \<API\_KEY> |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json   |

{% tabs %}
{% tab title="200: OK Deleted successfully" %}
```javascript
{message: 'ok'}
```
{% endtab %}

{% tab title="400: Bad Request Invalid API key or no query string provided" %}
```javascript
{
    "error": {
        "message": "Invalid API key"
    }
}
```
{% endtab %}

{% tab title="401: Unauthorized Missing API key" %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endtab %}
{% endtabs %}

## RuleFlow Export/Import

### Export Rule Flow with all rules

<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/rule-flow/export/:ruleFlowId/:version?`

Export Rule Flow with all rules. If the version is not specified, export Rule Flow with the latest version.

#### Path Parameters

| Name                                         | Type   | Description                                                   |
| -------------------------------------------- | ------ | ------------------------------------------------------------- |
| ruleFlowId<mark style="color:red;">\*</mark> | String | Unique rule flow ID or alias which is common to all versions. |
| version                                      | Number |                                                               |

#### Headers

| Name                                            | Type   | Description      |
| ----------------------------------------------- | ------ | ---------------- |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer           |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json |

{% tabs %}
{% tab title="200: OK OK" %}
```javascript
[
  {
    "_id": "62627b2ac0fc11362331185e",
    "name": "Sample Rule Flow",
    "description": "This is sample description",
    "inputSchema": {
      "period": {},
      "productType": {},
      "promoCode": {}
    },
    "outputSchema": {
      "finalPrice": {},
      "crudePrice": {},
      "message": {}
    },
    "type": "composition",
    "status": "pending",
    "visualEditorData": {
      "drawflow": {
        "Home": {
          "data": {
            "1": {
              "id": 1,
              "data": {
                "type": "start"
              },
              "inputs": {},
              "outputs": {
                "output_1": {
                  "connections": [
                    {
                      "node": "2",
                      "output": "input_1"
                    }
                  ]
                }
              },
              "pos_x": 57,
              "pos_y": 218
            },
            "2": {
              "id": 2,
              "data": {
                "type": "node",
                "baseId": "f36bf7cf-bef4-1f4c-d756-c0b6f2f814ff",
                "globalVariable": "Rule_1"
              },
              "inputs": {
                "input_1": {
                  "connections": [
                    {
                      "node": "1",
                      "input": "output_1"
                    }
                  ]
                }
              },
              "outputs": {
                "output_1": {
                  "connections": [
                    {
                      "node": "3",
                      "output": "input_1"
                    }
                  ]
                }
              },
              "pos_x": 400,
              "pos_y": 150
            },
            "3": {
              "id": 3,
              "data": {
                "type": "end"
              },
              "inputs": {
                "input_1": {
                  "connections": [
                    {
                      "node": "2",
                      "input": "output_1"
                    }
                  ]
                }
              },
              "outputs": {},
              "pos_x": 785,
              "pos_y": 212
            }
          }
        }
      }
    },
    "dataTree": {
      "children": [
        {
          "baseId": "f36bf7cf-bef4-1f4c-d756-c0b6f2f814ff",
          "children": [
            {
              "children": [
                null
              ],
              "globalVariable": "end",
              "mapping": [
                {
                  "key": "finalPrice",
                  "source": "Rule_1",
                  "sourceVariable": "prices.finalPrice"
                },
                {
                  "key": "crudePrice",
                  "source": "Rule_1",
                  "sourceVariable": "prices.crudePrice"
                },
                {
                  "key": "message",
                  "source": "Rule_1",
                  "sourceVariable": "message"
                }
              ]
            }
          ],
          "globalVariable": "Rule_1",
          "mapping": [
            {
              "key": "period",
              "source": "start",
              "sourceVariable": "period"
            },
            {
              "key": "productType",
              "source": "start",
              "sourceVariable": "productType"
            },
            {
              "key": "promoCode",
              "source": "start",
              "sourceVariable": "promoCode"
            }
          ]
        }
      ],
      "globalVariable": "start",
      "mapping": []
    },
    "compositionId": "94c5ef08-d609-ef88-066a-fbeda7d1e537",
    "version": 1,
    "createdIn": "2022-04-22T09:53:46.744Z",
    "lastUpdate": "2022-04-22T09:53:46.744Z"
  },
  {
    "_id": "62627b2ac0fc11362331185d",
    "name": "Sample Rule Flow",
    "description": "This rule is a part of Sample Rule Flow.",
    "inputSchema": {
      "period": {},
      "productType": {},
      "promoCode": {}
    },
    "outputSchema": {
      "prices": {
        "finalPrice": {},
        "crudePrice": {}
      },
      "message": {}
    },
    "decisionTable": {
      "columns": [
        {
          "condition": {
            "type": "simple",
            "inputVariable": "productType",
            "name": "Product type"
          },
          "columnId": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
          "type": "input"
        },
        {
          "condition": {
            "type": "simple",
            "inputVariable": "period",
            "name": "Subscription period"
          },
          "columnId": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
          "type": "input"
        },
        {
          "condition": {
            "type": "simple",
            "inputVariable": "promoCode",
            "name": "New Condition"
          },
          "columnId": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
          "type": "input"
        },
        {
          "columnOutput": {
            "type": "simple",
            "outputVariable": "prices.crudePrice",
            "name": "Price without discounts"
          },
          "columnId": "2e46eb73-de05-51bc-5913-4b261bbe2069",
          "type": "output"
        },
        {
          "columnOutput": {
            "type": "simple",
            "outputVariable": "prices.finalPrice",
            "name": "Final price"
          },
          "columnId": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
          "type": "output"
        },
        {
          "columnOutput": {
            "type": "simple",
            "outputVariable": "message",
            "name": "New Result"
          },
          "columnId": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
          "type": "output"
        }
      ],
      "rows": [
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "basic",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "=",
                "value": "{PromoCode}",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "type": "common",
                "value": "8"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "basic",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "<>",
                "value": "{PromoCode}",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "type": "common",
                "value": "8"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "basic",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "=",
                "value": "{PromoCode}",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "type": "function",
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    6,
                    12
                  ]
                }
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "basic",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "<>",
                "value": "{PromoCode}",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "type": "function",
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    6,
                    12
                  ]
                }
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "medium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "IN",
                "value": [
                  "{PromoCode}",
                  "BUSINESS SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": "15",
                "type": "common"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "medium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "NOT IN",
                "value": [
                  "{PromoCode}",
                  "BUSINESS SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": "15",
                "type": "common"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "medium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "IN",
                "value": [
                  "{PromoCode}",
                  "BUSINESS SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    12,
                    12
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "medium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "NOT IN",
                "value": [
                  "{PromoCode}",
                  "BUSINESS SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    12,
                    12
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "premium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "IN",
                "value": [
                  "{PromoCode}",
                  "DIAMOND SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": "25",
                "type": "common"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "premium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "month",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "NOT IN",
                "value": [
                  "{PromoCode}",
                  "DIAMOND SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": "25",
                "type": "common"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "premium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "IN",
                "value": [
                  "{PromoCode}",
                  "DIAMOND SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    21,
                    12
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    "{prices.crudePrice}",
                    {
                      "functionName": "DIVIDED",
                      "parameters": [
                        {
                          "functionName": "MINUS",
                          "parameters": [
                            100,
                            "{PromoDiscount}"
                          ]
                        },
                        100
                      ]
                    }
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": {
                  "functionName": "CONCAT",
                  "parameters": [
                    "\"{PromoDiscount}\"",
                    "\"% discount\""
                  ]
                },
                "type": "function"
              },
              "type": "output"
            }
          ],
          "active": true
        },
        {
          "cells": [
            {
              "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
              "scalarCondition": {
                "operator": "=",
                "value": "premium",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "ac44d6bf-ddd6-3778-7486-483c4bed53fd",
              "scalarCondition": {
                "operator": "=",
                "value": "year",
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "13b20cae-2d6f-0183-e970-b1c0fed5558f",
              "scalarCondition": {
                "operator": "NOT IN",
                "value": [
                  "{PromoCode}",
                  "DIAMOND SALE"
                ],
                "type": "general"
              },
              "type": "input"
            },
            {
              "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
              "outputScalarValue": {
                "value": {
                  "functionName": "TIMES",
                  "parameters": [
                    21,
                    12
                  ]
                },
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "92d6a186-702b-32f3-8d5d-ad1ab6b1c025",
              "outputScalarValue": {
                "value": "{prices.crudePrice}",
                "type": "function"
              },
              "type": "output"
            },
            {
              "column": "9fcb15be-aa42-9380-2145-4d2ff831aa34",
              "outputScalarValue": {
                "value": "\"no matching promo code\"",
                "type": "common"
              },
              "type": "output"
            }
          ],
          "active": true
        }
      ]
    },
    "type": "decision-table",
    "status": "published",
    "tags": [],
    "userVariables": [
      {
        "name": "PromoCode",
        "value": "SUMMER SALE",
        "saved": true,
        "editMode": true
      },
      {
        "name": "PromoDiscount",
        "value": 30,
        "saved": true,
        "editMode": true
      },
      {}
    ],
    "ruleId": "f36bf7cf-bef4-1f4c-d756-c0b6f2f814ff",
    "version": 1,
    "createdIn": "2022-04-22T09:53:46.586Z",
    "lastUpdate": "2022-04-22T09:53:46.586Z"
  }
]
```
{% endtab %}

{% tab title="400: Bad Request Invalid API key or ruleFlowId" %}
```javascript
{
  "error": {
    "message": "Invalid API key"
  }
}
```
{% endtab %}

{% tab title="426: Upgrade Required Operation not allowed" %}
```javascript
{
    // Response
}
```
{% endtab %}
{% endtabs %}

### Import Rule Flow with all rules

<mark style="color:green;">`POST`</mark> `https://api.decisionrules.io/api/rule-flow/import`

Import Rule Flow with all rules. If no query parameters are set, a new Rule Flow will be created. If the `new-version` and `version` query parameter are set, a new version of the targeted Rule Flow will be created. If the `overwrite` and `version` query parameters are set, a specific version of the target rule flow will be overwritten.

#### Query Parameters

| Name        | Type   | Description                          |
| ----------- | ------ | ------------------------------------ |
| new-version | String | ID or alias of the target Rule Flow. |
| overwrite   | String | ID or alias of the target Rule Flow. |
| version     | Number | Version of target Rule Flow          |

#### Headers

| Name                                            | Type   | Description      |
| ----------------------------------------------- | ------ | ---------------- |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer           |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json |

{% tabs %}
{% tab title="200: OK " %}
```javascript
{
  "_id": "62627b2ac0fc11362331185e",
  "name": "Sample Rule Flow",
  "description": "This is sample description",
  "inputSchema": {
    "period": {},
    "productType": {},
    "promoCode": {}
  },
  "outputSchema": {
    "finalPrice": {},
    "crudePrice": {},
    "message": {}
  },
  "type": "composition",
  "status": "pending",
  "visualEditorData": {
    "drawflow": {
      "Home": {
        "data": {
          "1": {
            "id": 1,
            "data": {
              "type": "start"
            },
            "inputs": {},
            "outputs": {
              "output_1": {
                "connections": [
                  {
                    "node": "2",
                    "output": "input_1"
                  }
                ]
              }
            },
            "pos_x": 57,
            "pos_y": 218
          },
          "2": {
            "id": 2,
            "data": {
              "type": "node",
              "baseId": "f36bf7cf-bef4-1f4c-d756-c0b6f2f814ff",
              "globalVariable": "Rule_1"
            },
            "inputs": {
              "input_1": {
                "connections": [
                  {
                    "node": "1",
                    "input": "output_1"
                  }
                ]
              }
            },
            "outputs": {
              "output_1": {
                "connections": [
                  {
                    "node": "3",
                    "output": "input_1"
                  }
                ]
              }
            },
            "pos_x": 400,
            "pos_y": 150
          },
          "3": {
            "id": 3,
            "data": {
              "type": "end"
            },
            "inputs": {
              "input_1": {
                "connections": [
                  {
                    "node": "2",
                    "input": "output_1"
                  }
                ]
              }
            },
            "outputs": {},
            "pos_x": 785,
            "pos_y": 212
          }
        }
      }
    }
  },
  "dataTree": {
    "children": [
      {
        "baseId": "f36bf7cf-bef4-1f4c-d756-c0b6f2f814ff",
        "children": [
          {
            "children": [
              null
            ],
            "globalVariable": "end",
            "mapping": [
              {
                "key": "finalPrice",
                "source": "Rule_1",
                "sourceVariable": "prices.finalPrice"
              },
              {
                "key": "crudePrice",
                "source": "Rule_1",
                "sourceVariable": "prices.crudePrice"
              },
              {
                "key": "message",
                "source": "Rule_1",
                "sourceVariable": "message"
              }
            ]
          }
        ],
        "globalVariable": "Rule_1",
        "mapping": [
          {
            "key": "period",
            "source": "start",
            "sourceVariable": "period"
          },
          {
            "key": "productType",
            "source": "start",
            "sourceVariable": "productType"
          },
          {
            "key": "promoCode",
            "source": "start",
            "sourceVariable": "promoCode"
          }
        ]
      }
    ],
    "globalVariable": "start",
    "mapping": []
  },
  "compositionId": "94c5ef08-d609-ef88-066a-fbeda7d1e537",
  "version": 1,
  "createdIn": "2022-04-22T09:53:46.744Z",
  "lastUpdate": "2022-04-22T09:53:46.744Z"
}
```
{% endtab %}

{% tab title="400: Bad Request Invalid API key" %}
```javascript
{
  "error": {
    "message": "Invalid API key"
  }
}
```
{% endtab %}

{% tab title="406: Not Acceptable Wrong Rule Flow format" %}
```javascript
{
    Error: Rule Flow is missing the property 'name'!
}
```
{% endtab %}

{% tab title="426: Upgrade Required Operation not allowed" %}
```javascript
{
    // Response
}
```
{% endtab %}
{% endtabs %}

## Folders

### Export folder with all rules

<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/folder/export/{nodeId}`

Export folder with all rules. If no nodeId is set, then will be exported root directory.

#### Path Parameters

| Name   | Type   | Description                                                                        |
| ------ | ------ | ---------------------------------------------------------------------------------- |
| nodeId | String | If you know your folder id, you can export it. Otherwise you export root directory |

#### Headers

| Name                                            | Type   | Description      |
| ----------------------------------------------- | ------ | ---------------- |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer           |

{% tabs %}
{% tab title="200: OK OK" %}

{% endtab %}

{% tab title="400: Bad Request Could not export folder" %}

{% endtab %}
{% endtabs %}

Use the endpoints listed below to manage the folder structure of your space.

All Folder endpoints make use of [Folder Paths](management-api.md#folder-paths) for convenience.&#x20;

{% swagger src="../.gitbook/assets/Folders_API_Docs.yaml" path="/folder/:targetNodeId" method="get" %}
[Folders_API_Docs.yaml](../.gitbook/assets/Folders_API_Docs.yaml)
{% endswagger %}

{% swagger src="../.gitbook/assets/Folders_API_Docs.yaml" path="/folder/:targetNodeId" method="post" %}
[Folders_API_Docs.yaml](../.gitbook/assets/Folders_API_Docs.yaml)
{% endswagger %}

{% hint style="info" %}
If the request body contains rules **(defined by baseId or ruleAlias)**, the are moved to fit with the request. In the request example below, if the space contains a rule with id "xxx-yyy-zzz", it will be moved into the newly created "Example Sub-Folder" Folder.

When moving Rules - If a version is not defined all of the rule versions will be moved.
{% endhint %}

{% swagger src="../.gitbook/assets/Folders_API_Docs.yaml" path="/folder/:targetNodeId" method="put" %}
[Folders_API_Docs.yaml](../.gitbook/assets/Folders_API_Docs.yaml)
{% endswagger %}

{% hint style="warning" %}
&#x20;Any existing Folder children of the target node will be deleted. (Rules, which aren't part of the request body will be moved to the root)
{% endhint %}

{% hint style="info" %}
If the request body contains rules **(defined by baseId or ruleAlias)**, the are moved to fit with the request. In the request example below, if the space contains a rule with id "xxx-yyy-zzz", it will be moved into the newly created "Example Sub-Folder" Folder.

When moving Rules - If a version is not defined all of the rule versions will be moved.
{% endhint %}

{% swagger src="../.gitbook/assets/Folders_API_Docs.yaml" path="/folder/:targetNodeId" method="delete" %}
[Folders_API_Docs.yaml](../.gitbook/assets/Folders_API_Docs.yaml)
{% endswagger %}

{% hint style="danger" %}
Data removal is permanent and cannot be undone.
{% endhint %}

{% swagger src="../.gitbook/assets/Folders_API_Docs.yaml" path="/folder/rename/:targetNodeId" method="patch" %}
[Folders_API_Docs.yaml](../.gitbook/assets/Folders_API_Docs.yaml)
{% endswagger %}

{% swagger src="../.gitbook/assets/Folders_API_Docs.yaml" path="/folder/move" method="put" %}
[Folders_API_Docs.yaml](../.gitbook/assets/Folders_API_Docs.yaml)
{% endswagger %}

{% swagger src="../.gitbook/assets/Folders_API_Docs.yaml" path="/folder/find" method="post" %}
[Folders_API_Docs.yaml](../.gitbook/assets/Folders_API_Docs.yaml)
{% endswagger %}

Searchable attribues:

* name - Name of the Folder or Rule
  * Note: this attribute searches for a RegExp match by default, if you wish to find nodes which match the input exactly prepend the input with "^" and append with "$". For example if you want to find items which are named exactly "ClientA", try searching "^ClientA$"
* id - ID of the Folder
* ruleAlias - Rule-Alias
  * Note: this attribute searches for a RegExp match by default, if you wish to find nodes which match the input exactly prepend the input with "^" and append with "$". For example if you want to find rules the exact alias "ClientA", try searching "^ClientA$"
* baseId - RuleId of the Rule or Rule Flow
* ruleType - type of rule
  * "decision-table" - Decision Table
  * "decision-tree" - Decision Tree
  * "complex-rule" - Scripting Rule
  * "composition" - Rule Flow
* tags - Tags on a Rule
* type - Type of Node in Folder Structure
  * FOLDER
  * RULE
  * ROOT
* version - Version of the rule
* ruleStatus
  * published
  * pending

### Export folder with all rules

<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/folder/export/{nodeId}`

{% hint style="info" %}
You can target the rule using [Folder Path](management-api.md#folder-paths) instead of the :ruleId and :version parameters.
{% endhint %}

#### Path Parameters

| Name   | Type   | Description  |
| ------ | ------ | ------------ |
| nodeId | String | CVAEjOf71DAP |

#### Path Query Parameters

<table><thead><tr><th width="128">Name</th><th width="134">Type</th><th>Description</th></tr></thead><tbody><tr><td>path</td><td>string</td><td>Unique folder path leading to the rule.</td></tr><tr><td>version</td><td>integer</td><td>Business rule version.</td></tr></tbody></table>

#### Headers

| Name                                            | Type   | Description  |
| ----------------------------------------------- | ------ | ------------ |
| Content-Type<mark style="color:red;">\*</mark>  | String | RGr6dnzLvhJy |
| Authorization<mark style="color:red;">\*</mark> | String | 2DWTCHKmYqZj |

### Import folder and all rules.

<mark style="color:green;">`POST`</mark> `https://api.decisionrules.io/api/folder/import/{targetNodeId}`

Import folder with all rules into specific folder. If no targetNodeId is set, then will be imported into root directory.

{% hint style="info" %}
You can target the rule using [Folder Path](management-api.md#folder-paths) instead of the :ruleId and :version parameters.
{% endhint %}

#### Path Parameters

| Name         | Type   | Description                                                                                       |
| ------------ | ------ | ------------------------------------------------------------------------------------------------- |
| targetNodeId | String | If you know you targetNodeId, you can import it. Otherwise you import folder into root directory. |

#### Path Query Parameters

<table><thead><tr><th width="128">Name</th><th width="134">Type</th><th>Description</th></tr></thead><tbody><tr><td>path</td><td>string</td><td>Unique folder path leading to the rule.</td></tr><tr><td>version</td><td>integer</td><td>Business rule version.</td></tr></tbody></table>

#### Headers

| Name                                            | Type   | Description      |
| ----------------------------------------------- | ------ | ---------------- |
| Content-Type<mark style="color:red;">\*</mark>  | String | application/json |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer           |

#### Request Body

| Name       | Type   | Description |
| ---------- | ------ | ----------- |
| export     | object |             |
| exportType | string |             |
| version    | number |             |
| createdAt  | Date   |             |
| data       | object |             |

{% tabs %}
{% tab title="200: OK OK" %}

{% endtab %}

{% tab title="400: Bad Request Could not import folder" %}

{% endtab %}
{% endtabs %}

{% file src="../.gitbook/assets/import_folder_example (1).json" %}

### Common Use cases

<details>

<summary>Create an empty folder in root</summary>

```javascript
async function createEmptyFolder(folderName) {
    // Create URL
    const url = "https://api.decisionrules.io/api/folder"
    
    // Define the new Folder
    const folderToCreate = {
        name: folderName,
        type: "FOLDER",
        children: []
    }

    // POST the folder
    const response = await fetch(url, {
        method: "POST",
        headers: {
            "Authorization": `Bearer ${ManagementApiKey}`,
            "Content-Type": "application/json"
        },
        body: JSON.stringify(folderToCreate)
    })
    
    return;
}
// Set the folder name
createEmptyFolder('New Folder')
```

</details>

<details>

<summary>Migrate Rules and Folders from one Space to another</summary>

```javascript
async function migrateSpace(oldSpaceManagementKey, targetSpaceManagementKey) {
    // Create URL
    try {
        const url = 'https://api.decisionrules.io/api/folder/';
    
        // Export old Space contents
        const exportResponse = await fetch(url + 'export', {
            method: "GET",
            headers: {
                "Authorization": `Bearer ${oldSpaceManagementKey}`,
                "Content-Type": "application/json"
            }
        })
        
        // Convert response to json
        const exportedFolder = await exportResponse.json()
    
        // Import the Folder into the new Space
        // This creates a folder named "Home (Imported)" in the target Space.
        const importResponse = await fetch(url + 'import', {
            method: "POST",
            headers: {
                "Authorization": `Bearer ${targetSpaceManagementKey}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify(exportedFolder)
        })
        
        const createdFolderIdObject = await importResponse.json()
        const createdFolderId = createdFolderIdObject.folderNode

        // Get Folder Structure of created Node
        const folderStructureResponse = await fetch(url + createdFolderId, {
            method: "GET",
            headers: {
                "Authorization": `Bearer ${targetSpaceManagementKey}`,
                "Content-Type": "application/json"
            }
        })
        // Convert response to json
        const FolderStructure = await folderStructureResponse.json()
        
        // Move all folders from the "Home (Imported)" folder 
        // out to the root to maintain Folder Structure
        
        // Prepare Move request
        const nodesToMove = FolderStructure.children
        nodesToMove.forEach(child => {
            delete child.name
            delete child.children
            delete child.baseId
        })
        const moveRequest = {
            targetId: 'root',
            nodes: nodesToMove
        }
        // Move the nodes
        await fetch(url + 'move', {
            method: "PUT",
            headers: {
                "Authorization": `Bearer ${targetSpaceManagementKey}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify(moveRequest)
        })  
    
        // Delete the empty "Home" folder
        await fetch(url + `${createdFolderId}`, {
            method: "DELETE",
            headers: {
                "Authorization": `Bearer ${targetSpaceManagementKey}`,
                "Content-Type": "application/json"
            },
        })  
        console.log('Migration Completed Successfully')
    }
    catch(e) {
        console.log(`Error occured during migration: ${e.message}`)
    }
}

const sourceApiKey = '<SOURCE_SPACE_MANAGEMENT_API_KEY>';
const targetApiKey = '<TARGET_SPACE_MANAGEMENT_API_KEY>';

migrateSpace(sourceApiKey, targetApiKey);
```

</details>



## Tools

There are some additional tools for individual rules that can be taken advantage of. Their description can be found below.

### Find duplicate conditions in decision table

<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/tools/duplicates/{ruleId}/{version}`

Look for decision table by id and optionally version. If the decision table is found, it is returned together with an array of duplicates.

#### Path Parameters

| Name                                     | Type   | Description  |
| ---------------------------------------- | ------ | ------------ |
| ruleId<mark style="color:red;">\*</mark> | String |              |
| version                                  | String | rule version |

{% tabs %}
{% tab title="200: OK OK" %}

{% endtab %}

{% tab title="400: Bad Request Rule does not exist or is not decision table" %}

{% endtab %}
{% endtabs %}

<details>

<summary>Response Example</summary>

```json
{
    "rule": {
        "_id": "6305ec5a42a45d1591c40767",
        "name": "Simple Sample",
        "description": "",
        "inputSchema": {
            "input": {}
        },
        "outputSchema": {
            "output": {}
        },
        "decisionTable": {
            "columns": [
                {
                    "condition": {
                        "type": "simple",
                        "inputVariable": "input",
                        "name": "New Condition"
                    },
                    "columnId": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                    "type": "input"
                },
                {
                    "columnOutput": {
                        "type": "simple",
                        "outputVariable": "output",
                        "name": "New Result"
                    },
                    "columnId": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                    "type": "output"
                }
            ],
            "rows": [
                {
                    "cells": [
                        {
                            "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                            "scalarCondition": {
                                "operator": "=",
                                "value": "0",
                                "type": "general"
                            },
                            "type": "input"
                        },
                        {
                            "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                            "outputScalarValue": {
                                "type": "common",
                                "value": "A"
                            },
                            "type": "output"
                        }
                    ],
                    "active": true
                },
                {
                    "cells": [
                        {
                            "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                            "scalarCondition": {
                                "operator": "=",
                                "value": "1",
                                "type": "general"
                            },
                            "type": "input"
                        },
                        {
                            "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                            "outputScalarValue": {
                                "type": "common",
                                "value": "B"
                            },
                            "type": "output"
                        }
                    ],
                    "active": true
                },
                {
                    "cells": [
                        {
                            "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                            "scalarCondition": {
                                "operator": "=",
                                "value": "1",
                                "type": "general"
                            },
                            "type": "input"
                        },
                        {
                            "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                            "outputScalarValue": {
                                "type": "common",
                                "value": "BB"
                            },
                            "type": "output"
                        }
                    ],
                    "active": true
                },
                {
                    "cells": [
                        {
                            "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                            "scalarCondition": {
                                "operator": "=",
                                "value": "2",
                                "type": "general"
                            },
                            "type": "input"
                        },
                        {
                            "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                            "outputScalarValue": {
                                "type": "common",
                                "value": "C"
                            },
                            "type": "output"
                        }
                    ],
                    "active": true
                },
                {
                    "cells": [
                        {
                            "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                            "scalarCondition": {
                                "operator": "=",
                                "value": "1",
                                "type": "general"
                            },
                            "type": "input"
                        },
                        {
                            "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                            "outputScalarValue": {
                                "type": "common",
                                "value": "BBB"
                            },
                            "type": "output"
                        }
                    ],
                    "active": true
                }
            ]
        },
        "type": "decision-table",
        "status": "published",
        "auditLog": {
            "active": false,
            "debug": {
                "active": false
            },
            "ttl": 14
        },
        "ruleId": "3ea681e8-256a-7ddf-9fd2-e79fac231d60",
        "version": 1,
        "tags": [],
        "baseId": "3ea681e8-256a-7ddf-9fd2-e79fac231d60",
        "createdIn": "2022-08-24T09:16:10.142Z",
        "lastUpdate": "2022-08-24T09:17:56.036Z"
    },
    "duplicates": [
        {
            "indices": [
                1,
                2,
                4
            ],
            "rows": [
                {
                    "cells": [
                        {
                            "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                            "scalarCondition": {
                                "operator": "=",
                                "value": "1",
                                "type": "general"
                            },
                            "type": "input"
                        },
                        {
                            "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                            "outputScalarValue": {
                                "type": "common",
                                "value": "B"
                            },
                            "type": "output"
                        }
                    ],
                    "active": true
                },
                {
                    "cells": [
                        {
                            "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                            "scalarCondition": {
                                "operator": "=",
                                "value": "1",
                                "type": "general"
                            },
                            "type": "input"
                        },
                        {
                            "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                            "outputScalarValue": {
                                "type": "common",
                                "value": "BB"
                            },
                            "type": "output"
                        }
                    ],
                    "active": true
                },
                {
                    "cells": [
                        {
                            "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                            "scalarCondition": {
                                "operator": "=",
                                "value": "1",
                                "type": "general"
                            },
                            "type": "input"
                        },
                        {
                            "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                            "outputScalarValue": {
                                "type": "common",
                                "value": "BBB"
                            },
                            "type": "output"
                        }
                    ],
                    "active": true
                }
            ]
        }
    ]
}
```

</details>

### Find all dependencies of a rule

<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/tools/dependencies/{identifier}/{version}`

Look for dependencies by id or alias and optionally version. If the rule is found, it is returned together with an array of dependencies.

#### Path Parameters

| Name                                         | Type   | Description                                                    |
| -------------------------------------------- | ------ | -------------------------------------------------------------- |
| identifier<mark style="color:red;">\*</mark> | String | Id or Alias of the rule, you want to find out dependencies of. |
| version                                      | String |                                                                |

{% tabs %}
{% tab title="200: OK OK" %}

{% endtab %}

{% tab title="400: Bad Request Rule does not exist or couldn't find dependencies." %}

{% endtab %}
{% endtabs %}

<details>

<summary>Response Example</summary>



```json
{
    "rule": {
        "baseId": "8803df20-b515-0c2f-d916-c1621456a350",
        "version": 1,
        "ruleAlias": "handsome-rhinoceros",
        "name": "Import Rule",
        "type": "composition",
        "status": "published"
    },
    "dependencies": [
        {
            "baseId": "6c75221b-3d00-6665-a229-852ada5a921c",
            "version": 1,
            "ruleAlias": "blonde-wolf",
            "name": "Import Rule",
            "type": "decision-table",
            "status": "published",
            "parent": {
                "baseId": "8803df20-b515-0c2f-d916-c1621456a350",
                "version": 1,
                "ruleAlias": "handsome-rhinoceros",
                "name": "Import Rule",
                "type": "composition",
                "status": "published"
            }
        }
    ]
}
```

</details>
