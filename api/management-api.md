---
description: >-
  The Management API is a secure REST API that provides read/write access to
  your rules and spaces.
cover: >-
  https://images.unsplash.com/photo-1623282033815-40b05d96c903?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwxfHxBUEl8ZW58MHx8fHwxNjM0NzM3NjYx&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Management API

HTTP API Request methods cheat sheet:&#x20;

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

### Swagger

You can check out these endpoints and call them right away using swagger.

**Swagger UI:** [https://api.decisionrules.io/api/docs/](https://api.decisionrules.io/api/docs/)

**Swagger JSON File:** [https://api.decisionrules.io/api/docs/json](https://api.decisionrules.io/api/docs/json)

### Rule

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version?" method="get" summary="Get rule" %}
{% swagger-description %}
Gets all of the infromation stored about the rule, including its content, version or input and output schemas.&#x20;

If the version is specified, gets the version irrespective of the rule status.

If the version is not specified, gets the **latest published** version.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" required="true" %}
Unique rule ID or alias which is common to all rule versions.
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" required="false" %}
Business rule version.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-response status="200" description="" %}
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
{% endswagger-response %}

{% swagger-response status="400" description="" %}
```
Error: This rule belongs to another user OR rule not found
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
Get rule might be useful when you wish to create a new version of a rule. To do so you may <mark style="color:blue;">GET</mark> the rule, manually change the `"version"`attribute of the returned JSON object and then use said object with the <mark style="color:green;">POST</mark> Create rule method. This will result in a new version of the rule being created.
{% endhint %}

{% swagger method="put" path="/api/rule/status/:ruleId/:status/:version?" baseUrl="https://api.decisionrules.io" summary="Update rule status" %}
{% swagger-description %}
Changes rule status from <mark style="color:orange;">pending</mark> to <mark style="color:green;">published</mark> and vice versa. If the version is not specified, the latest version will be used.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" required="true" %}
Unique rule ID or alias which is common to all rule versions.
{% endswagger-parameter %}

{% swagger-parameter in="path" name="status" required="true" %}
<mark style="color:orange;">pending</mark> XOR <mark style="color:green;">published</mark>
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer MANAGEMENT\_API\_KEY
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="Number" %}
rule version
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Status has been successfully updated " %}
UpReturns updated rule.
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="One or more PATH parameters are invalid" %}
```javascript
{
    // Response
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="put" summary="Update rule" %}
{% swagger-description %}
Changes the rule according to the body of the request.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" required="true" %}
Unique rule ID or alias which is common to all rule versions.
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" required="true" %}
Version of Rule
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-parameter in="body" name="body" type="object" required="true" %}
A complete rule in JSON format
{% endswagger-parameter %}

{% swagger-response status="200" description="The rule has been updated" %}
```
```
{% endswagger-response %}

{% swagger-response status="400" description="" %}
```
TypeError: rule.decisionTable.rows is not iterable
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
Update rule might be useful when renaming a rule. First <mark style="color:blue;">GET</mark> the rule you wish to rename, change the`name`attribute of the returned JSON object and then use <mark style="color:orange;">PUT</mark> Update rule with the changed JSON object.
{% endhint %}

Note that there are a few attributes of the rule that cannot be updated by the <mark style="color:orange;">`PUT`</mark> endpoint. Namely, you cannot use <mark style="color:orange;">`PUT`</mark> to change the rule ID, version and rule alias. Also, you cannot change the date of last update, since it gets updated automatically.

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule" method="post" summary="Create rule" %}
{% swagger-description %}
Creates rule based on the body of the request. The body must be formatted according to the example below.
{% endswagger-description %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer \<MANAGEMENT\_API\_KEY>
{% endswagger-parameter %}

{% swagger-response status="200" description="Change has been made" %}
```
```
{% endswagger-response %}

{% swagger-response status="400" description="Invalid API key or ruleId" %}
```
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

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="delete" summary="Delete rule" %}
{% swagger-description %}
Deletes the rule.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" required="true" %}
Unique rule ID or alias which is common to all rule versions.
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" required="false" %}
Version of Rule. If not specified, all versions will be deleted!
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-response status="200" description="" %}
```
```
{% endswagger-response %}

{% swagger-response status="400" description="Invalid API key or ruleId" %}
```
Error: This rule belongs to another user OR rule not found
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

{% hint style="warning" %}
If you do not specify version of the rule to be deleted, the endpoint will delete **all versions of the rule**. Please, use it with caution! Once deleted, rules cannot be recovered.
{% endhint %}

## Space

{% swagger method="get" path="/api/space/items" baseUrl="https://api.decisionrules.io" summary="Gets all types of rules and ruleflows in space" %}
{% swagger-description %}
The desired space is determined by Management API Key. This endpoint also gets set of rules used in every ruleflow.
{% endswagger-description %}

{% swagger-parameter in="header" name="Authorizaion" required="true" %}
Bearer \<API\_KEY>
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="" %}
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
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="" %}
```javascript
{
    // Response
}
```
{% endswagger-response %}

{% swagger-response status="401: Unauthorized" description="" %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endswagger-response %}
{% endswagger %}

## Tag

{% swagger method="get" path="/api/tags/items" baseUrl="https://api.decisionrules.io" summary="Get Rules/Rule Flows by tags" %}
{% swagger-description %}
This endpoint allows you to get all rules/rule flows with certain tags. Desired space is derived from Management API Key.
{% endswagger-description %}

{% swagger-parameter in="query" name="tags" type="string" required="true" %}
Comma separated list of tags. The query at the end of the url address should look like this: ?tags=tag1,tag2. Such query would select all the rules where tag array contains both tag1 and tag
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer \<API\_KEY>
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Returns an array of rules and rule flows." %}
```
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
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API key or no query added." %}
```javascript
{
    "error": {
        "message": "Invalid API key"
    }
}
```
{% endswagger-response %}

{% swagger-response status="401: Unauthorized" description="Missing API key." %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="patch" path="/api/tags/:id/:version?" baseUrl="https://api.decisionrules.io" summary="Add tags to Rule/Rule Flow" %}
{% swagger-description %}
If you specify the version, the tag/tags will be added to the specified version. If the version is not specified, the tag/tags will be added to all the versions with given ID.
{% endswagger-description %}

{% swagger-parameter in="path" name="id" type="string" required="true" %}
Unique rule ID or alias which is common to all rule versions. **You can also use rule alias.**
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="string" %}
version of Rule/Rule Flow
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer \<API\_KEY>
{% endswagger-parameter %}

{% swagger-parameter in="body" required="true" name="body" type="array" %}
array of tags to add i JSON format
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Added successfully" %}
```javascript
{message: "ok"}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API key or no tag array provided" %}
```javascript
{
    "error": {
        "message": "Invalid API key"
    }
}
```
{% endswagger-response %}

{% swagger-response status="401: Unauthorized" description="Missing API key" %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endswagger-response %}
{% endswagger %}

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

{% swagger method="delete" path="/api/tags/:id/:version?" baseUrl="https://api.decisionrules.io" summary="Delete tags from Rule/Rule Flow" %}
{% swagger-description %}
If you specify the version, the tag/tags will be deleted from the specified version. If the version is not specified, the tag/tags will be deleted from all the versions with given ID.
{% endswagger-description %}

{% swagger-parameter in="path" name="id" type="string" required="true" %}
Unique rule ID or alias which is common to all rule versions. **You can also use rule alias.**
{% endswagger-parameter %}

{% swagger-parameter in="query" name="tags" type="string" required="true" %}
Comma separated list of tags. The query at the end of the url address should look like this: ?tags=tag1,tag2
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="string" %}
version of Rule/Rule Flow
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer \<API\_KEY>
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Deleted successfully" %}
```javascript
{message: 'ok'}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API key or no query string provided" %}
```javascript
{
    "error": {
        "message": "Invalid API key"
    }
}
```
{% endswagger-response %}

{% swagger-response status="401: Unauthorized" description="Missing API key" %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endswagger-response %}
{% endswagger %}

## Rule Flow

{% hint style="success" %}
Since version 1.16.0 rule flows can be easily accessed with rule endpoints.
{% endhint %}

Following Rule Flow endpoints are now deprecated and can be find below in page section [Deprecated endpoints](management-api.md#deprecated-endpoints):

* <mark style="color:blue;">GET</mark> Get Rule Flow
* <mark style="color:orange;">PUT</mark> Update Rule Flow
* <mark style="color:orange;">PUT</mark> Update Rule Flow status
* <mark style="color:green;">POST</mark> Create Rule Flow
* &#x20;<mark style="color:red;">DELETE</mark> Delete Rule Flow

There are still two ruleflow only methods. You will find them useful espacially when you want to import your ruleflow to another space.

{% swagger method="get" path="/api/rule-flow/export/:ruleFlowId/:version?" baseUrl="https://api.decisionrules.io" summary="Export Rule Flow with all rules" %}
{% swagger-description %}
Export Rule Flow with all rules. If the version is not specified, export Rule Flow with the latest version.
{% endswagger-description %}

{% swagger-parameter in="path" required="true" name="ruleFlowId" type="String" %}
Unique rule flow ID or alias which is common to all versions.
{% endswagger-parameter %}

{% swagger-parameter in="path" required="false" name="version" type="Number" %}

{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="OK" %}
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
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API key or ruleFlowId" %}
```javascript
{
  "error": {
    "message": "Invalid API key"
  }
}
```
{% endswagger-response %}

{% swagger-response status="426: Upgrade Required" description="Operation not allowed" %}
```javascript
{
    // Response
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="post" path="/api/rule-flow/import" baseUrl="https://api.decisionrules.io" summary="Import Rule Flow with all rules" %}
{% swagger-description %}
Import Rule Flow with all rules. If no query parameters are set, a new Rule Flow will be created. If the `new-version` and `version` query parameter are set, a new version of the targeted Rule Flow will be created. If the `overwrite` and `version` query parameters are set, a specific version of the target rule flow will be overwritten.
{% endswagger-description %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-parameter in="query" name="new-version" type="String" %}
ID or alias of the target Rule Flow.
{% endswagger-parameter %}

{% swagger-parameter in="query" name="overwrite" type="String" %}
ID or alias of the target Rule Flow.
{% endswagger-parameter %}

{% swagger-parameter in="query" name="version" type="Number" %}
Version of target Rule Flow
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="" %}
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
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API key" %}
```javascript
{
  "error": {
    "message": "Invalid API key"
  }
}
```
{% endswagger-response %}

{% swagger-response status="406: Not Acceptable" description="Wrong Rule Flow format" %}
```javascript
{
    Error: Rule Flow is missing the property 'name'!
}
```
{% endswagger-response %}

{% swagger-response status="426: Upgrade Required" description="Operation not allowed" %}
```javascript
{
    // Response
}
```
{% endswagger-response %}
{% endswagger %}

#### Request example

{% file src="../.gitbook/assets/Import-RuleFlow-example.json" %}

## Folder

Exporting and importing folders are useful features, enabling users to back up their data, transfer data between spaces, or share folders with others. Here's a description of the folder endpoints related to exporting and importing.

### Export Folder

{% swagger src="../.gitbook/assets/swagger.json" path="/folder/export/{nodeId}" method="get" %}
[swagger.json](../.gitbook/assets/swagger.json)
{% endswagger %}

### Import Folder

{% swagger src="../.gitbook/assets/swagger (2).json" path="/folder/import/{targetNodeId}" method="post" %}
[swagger (2).json](<../.gitbook/assets/swagger (2).json>)
{% endswagger %}

#### Import folder example

{% file src="../.gitbook/assets/import_folder_example (1).json" %}

## Tools

There are some additional tools for individual rules that can be taken advantage of. Their description can be found below.

### Find Duplicates in Decision Table

{% swagger src="../.gitbook/assets/swagger (1).json" path="/tools/duplicates/{ruleId}/{version}" method="get" %}
[swagger (1).json](<../.gitbook/assets/swagger (1).json>)
{% endswagger %}

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

### Find dependencies

{% swagger src="../.gitbook/assets/swagger.json" path="/tools/dependencies/{identifier}/{version}" method="get" %}
[swagger.json](../.gitbook/assets/swagger.json)
{% endswagger %}

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

## Deprecated Endpoints

All of these endpoints will be deprecated from version 1.7.1 and newer.

### Rule

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:spaceId" method="post" summary="Create rule" %}
{% swagger-description %}
Creates rule in space from JSON
{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" required="true" %}
Id of Space
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-response status="200" description="Change has been made" %}
```
```
{% endswagger-response %}

{% swagger-response status="400" description="Invalid API key or ruleId" %}
```
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

## Rule Flow

{% swagger method="get" path="/api/rule-flow/:ruleFlowId/:version?" baseUrl="https://api.decisionrules.io" summary="Get Rule Flow" %}
{% swagger-description %}
If the version is not specified, get Rule Flow with the latest version.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleFlowId" required="true" type="String" %}
Unique rule flow ID which is common to all versions.
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="Number" required="false" %}
Version of Rule Flow
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="" %}
```json
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
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API Key or ruleFlowId" %}
```javascript
{
  "error": {
    "message": "Invalid API key"
  }
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="put" path="/api/rule-flow/status/:ruleId/:status/:version" baseUrl="https://api.decisionrules.io" summary="Update Rule Flow Status" %}
{% swagger-description %}
Changes rule status from <mark style="color:orange;">pending</mark> to <mark style="color:green;">published</mark> and vice versa. If the version is not specified, the latest version will be used.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" required="true" %}
Unique rule flow ID which is common to all versions.
{% endswagger-parameter %}

{% swagger-parameter in="path" name="status" required="true" %}
<mark style="color:orange;">pending</mark> XOR <mark style="color:green;">published</mark>
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="number" required="true" %}
rule flow version
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Status has been successfully updated " %}
```javascript
{
    // Response
}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="One or more PATH parameters are invalid" %}
```javascript
{
    // Response
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="put" path="/api/rule-flow/:ruleFlowId/:version" baseUrl="https://api.decisionrules.io" summary="Update Rule Flow" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="ruleFlowId" type="String" required="true" %}
Unique rule flow ID which is common to all versions.
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="Number" required="true" %}
Version of Rule Flow
{% endswagger-parameter %}

{% swagger-parameter in="body" name="Rule Flow" type="Object" required="true" %}
Model of Rule Flow
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="" %}
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
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API key or ruleFlowId" %}
```javascript
{
  "error": {
    "message": "Invalid API key"
  }
}
```
{% endswagger-response %}

{% swagger-response status="406: Not Acceptable" description="Wrong Rule Flow format" %}
```javascript
{
    Error: Rule Flow is missing the property 'name'!
}
```
{% endswagger-response %}

{% swagger-response status="426: Upgrade Required" description="Operation not allowed" %}
```javascript
{
    // Response
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="post" path="/api/rule-flow" baseUrl="https://api.decisionrules.io" summary="Create Rule Flow" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="body" name="Rule Flow" type="Object" required="true" %}
Model of Rule Flow
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="" %}
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
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API key or ruleFlowId" %}
```javascript
{
  "error": {
    "message": "Invalid API key"
  }
}
```
{% endswagger-response %}

{% swagger-response status="406: Not Acceptable" description="Wrong Rule Flow format" %}
```javascript
{
    Error: Rule Flow is missing the property 'name'!
}
```
{% endswagger-response %}

{% swagger-response status="426: Upgrade Required" description="Operation not allowed" %}
```javascript
{
    // Response
}
```
{% endswagger-response %}
{% endswagger %}

#### Ruleflow request body example

This example serves as a template for request bodies when creating rules with <mark style="color:green;">POST</mark> Create rule. \
When updating rules with <mark style="color:orange;">PUT</mark> Update rule, the body of the request must have the same format as well.&#x20;

<details>

<summary>request body example</summary>

```json
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

</details>

{% swagger method="delete" path="/api/rule-flow/:ruleFlowId/:version" baseUrl="https://api.decisionrules.io" summary="Delete Rule Flow" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="ruleFlowId" type="String" required="true" %}
Unique rule flow ID which is common to all versions.
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="Number" required="true" %}
Version of Rule Flow
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="" %}
```javascript
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API key or ruleFlowId" %}
```javascript
{
  "error": {
    "message": "Invalid API key"
  }
}
```
{% endswagger-response %}
{% endswagger %}

{% hint style="warning" %}
If you do not specify version of the rule to be deleted, the endpoint will delete **all versions of the rule**. Please, use it with caution! Once deleted, rules cannot be recovered.
{% endhint %}

### Spaces

{% swagger baseUrl="https://api.decisionrules.io" path="/api/space/:spaceId" method="get" summary="Get all rules/rule flows in space" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" required="true" %}
ID of space
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer \<API\_KEY>
{% endswagger-parameter %}

{% swagger-response status="200" description="" %}
```
[
  {
    "ruleId": "00bcbe6e-5274-999e-5d75-b18c4d032510",
    "name": "Client Classification",
    "state": "published",
    "version": 1,
    "last_updated": "2021-08-27T04:51:24.436Z",
    "note": "Basic client classification rule",
    "type": "Decision Table",
    "tags": ["tagName", "anotherTagName"]
  }
]
```
{% endswagger-response %}

{% swagger-response status="400" description="" %}
```
Wrong spaceId!
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

### Tags

{% swagger method="get" path="/api/tags/rules/:spaceId" baseUrl="https://api.decisionrules.io" summary="Get rules by tag/tags" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="query" name="tags" type="string" required="true" %}
Comma separated list of tags. The query at the end of the url address should look like this: ?tags=tag1,tag2. Such query would select all the rules where tag array contains both tag1 and tag2.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer \<API\_KEY>
{% endswagger-parameter %}

{% swagger-parameter in="path" name="spaceId" type="string" required="true" %}
ID of space
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="Returns an array of rules." %}
```javascript
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
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API key or no query added." %}
```javascript
{
    "error": {
        "message": "Invalid API key"
    }
}
```
{% endswagger-response %}

{% swagger-response status="401: Unauthorized" description="API key missing." %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="patch" path="/api/tags/rules/:spaceId/:ruleId/:version?" baseUrl="https://api.decisionrules.io" summary="Add tags to rule" %}
{% swagger-description %}
If you specify the version, the tag/tags will be added to the specified version. If the version is not specified, the tag/tags will be added to all the versions with given rule ID.
{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" required="true" %}
ID of space
{% endswagger-parameter %}

{% swagger-parameter in="path" name="ruleId" type="string" required="true" %}
ID of rule
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="string" required="false" %}
Version of rule
{% endswagger-parameter %}

{% swagger-parameter in="body" type="array" name="body" required="true" %}
Array of tags to add
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer \<API\_KEY>
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="" %}
```javascript
{message: 'ok'}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API key or no tag array provided" %}
```javascript
{
    "error": {
        "message": "Invalid API key"
    }
}
```
{% endswagger-response %}

{% swagger-response status="401: Unauthorized" description="API key missing." %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endswagger-response %}
{% endswagger %}

{% swagger method="delete" path="/api/tags/rules/:spaceId/:ruleId/:version?" baseUrl="https://api.decisionrules.io" summary="Delete tags from rule" %}
{% swagger-description %}
If you specify the version, the tag/tags will be deleted from the specified version. If the version is not specified, the tag/tags will be removed from all the versions with given rule ID.
{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" required="true" %}
ID of space
{% endswagger-parameter %}

{% swagger-parameter in="path" name="ruleId" type="string" required="true" %}
ID of rule
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="string" required="false" %}
Version of rule
{% endswagger-parameter %}

{% swagger-parameter in="query" name="tags" type="string" required="true" %}
Comma separated list of tags. The query at the end of the url address should look like this: ?tags=tag1,tag2
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer \<API\_KEY>
{% endswagger-parameter %}

{% swagger-response status="200: OK" description="" %}
```javascript
{message: 'ok'}
```
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="Invalid API key or no query string provided" %}
```javascript
{
    "error": {
        "message": "Invalid API key"
    }
}
```
{% endswagger-response %}

{% swagger-response status="401: Unauthorized" description="API key missing." %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endswagger-response %}
{% endswagger %}
