# Deprecated Endpoints

## Deprecated Endpoints

All of these endpoints will be deprecated from version 1.7.1 and newer.

### Rule

## Create rule

<mark style="color:green;">`POST`</mark> `https://api.decisionrules.io/api/rule/:spaceId`

Creates rule in space from JSON

#### Path Parameters

| Name                                      | Type   | Description |
| ----------------------------------------- | ------ | ----------- |
| spaceId<mark style="color:red;">\*</mark> | string | Id of Space |

#### Headers

| Name                                            | Type   | Description |
| ----------------------------------------------- | ------ | ----------- |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer      |

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

## Rule Flow

## Get Rule Flow

<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/rule-flow/:ruleFlowId/:version?`

If the version is not specified, get Rule Flow with the latest version.

#### Path Parameters

| Name                                         | Type   | Description                                          |
| -------------------------------------------- | ------ | ---------------------------------------------------- |
| ruleFlowId<mark style="color:red;">\*</mark> | String | Unique rule flow ID which is common to all versions. |
| version                                      | Number | Version of Rule Flow                                 |

#### Headers

| Name                                            | Type   | Description |
| ----------------------------------------------- | ------ | ----------- |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer      |

{% tabs %}
{% tab title="200: OK " %}
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
{% endtab %}

{% tab title="400: Bad Request Invalid API Key or ruleFlowId" %}
```javascript
{
  "error": {
    "message": "Invalid API key"
  }
}
```
{% endtab %}
{% endtabs %}

## Update Rule Flow Status

<mark style="color:orange;">`PUT`</mark> `https://api.decisionrules.io/api/rule-flow/status/:ruleId/:status/:version`

Changes rule status from <mark style="color:orange;">pending</mark> to <mark style="color:green;">published</mark> and vice versa. If the version is not specified, the latest version will be used.

#### Path Parameters

| Name                                      | Type   | Description                                                                                |
| ----------------------------------------- | ------ | ------------------------------------------------------------------------------------------ |
| ruleId<mark style="color:red;">\*</mark>  | String | Unique rule flow ID which is common to all versions.                                       |
| status<mark style="color:red;">\*</mark>  | String | <mark style="color:orange;">pending</mark> XOR <mark style="color:green;">published</mark> |
| version<mark style="color:red;">\*</mark> | number | rule flow version                                                                          |

{% tabs %}
{% tab title="200: OK Status has been successfully updated " %}
```javascript
{
    // Response
}
```
{% endtab %}

{% tab title="400: Bad Request One or more PATH parameters are invalid" %}
```javascript
{
    // Response
}
```
{% endtab %}
{% endtabs %}

## Update Rule Flow

<mark style="color:orange;">`PUT`</mark> `https://api.decisionrules.io/api/rule-flow/:ruleFlowId/:version`

#### Path Parameters

| Name                                         | Type   | Description                                          |
| -------------------------------------------- | ------ | ---------------------------------------------------- |
| ruleFlowId<mark style="color:red;">\*</mark> | String | Unique rule flow ID which is common to all versions. |
| version<mark style="color:red;">\*</mark>    | Number | Version of Rule Flow                                 |

#### Headers

| Name                                            | Type   | Description |
| ----------------------------------------------- | ------ | ----------- |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer      |

#### Request Body

| Name                                        | Type   | Description        |
| ------------------------------------------- | ------ | ------------------ |
| Rule Flow<mark style="color:red;">\*</mark> | Object | Model of Rule Flow |

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

{% tab title="400: Bad Request Invalid API key or ruleFlowId" %}
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

## Create Rule Flow

<mark style="color:green;">`POST`</mark> `https://api.decisionrules.io/api/rule-flow`

#### Headers

| Name                                            | Type   | Description |
| ----------------------------------------------- | ------ | ----------- |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer      |

#### Request Body

| Name                                        | Type   | Description        |
| ------------------------------------------- | ------ | ------------------ |
| Rule Flow<mark style="color:red;">\*</mark> | Object | Model of Rule Flow |

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

{% tab title="400: Bad Request Invalid API key or ruleFlowId" %}
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

## Delete Rule Flow

<mark style="color:red;">`DELETE`</mark> `https://api.decisionrules.io/api/rule-flow/:ruleFlowId/:version`

#### Path Parameters

| Name                                         | Type   | Description                                          |
| -------------------------------------------- | ------ | ---------------------------------------------------- |
| ruleFlowId<mark style="color:red;">\*</mark> | String | Unique rule flow ID which is common to all versions. |
| version<mark style="color:red;">\*</mark>    | Number | Version of Rule Flow                                 |

#### Headers

| Name                                            | Type   | Description |
| ----------------------------------------------- | ------ | ----------- |
| Authorization<mark style="color:red;">\*</mark> | String | Bearer      |

{% tabs %}
{% tab title="200: OK " %}
```javascript
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
{% endtabs %}

{% hint style="warning" %}
If you do not specify version of the rule to be deleted, the endpoint will delete **all versions of the rule**. Please, use it with caution! Once deleted, rules cannot be recovered.
{% endhint %}

### Spaces

## Get all rules/rule flows in space

<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/space/:spaceId`

#### Path Parameters

| Name                                      | Type   | Description |
| ----------------------------------------- | ------ | ----------- |
| spaceId<mark style="color:red;">\*</mark> | string | ID of space |

#### Headers

| Name                                            | Type   | Description        |
| ----------------------------------------------- | ------ | ------------------ |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer \<API\_KEY> |

{% tabs %}
{% tab title="200 " %}
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
{% endtab %}

{% tab title="400 " %}
```
Wrong spaceId!
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

### Tags

## Get rules by tag/tags

<mark style="color:blue;">`GET`</mark> `https://api.decisionrules.io/api/tags/rules/:spaceId`

#### Path Parameters

| Name                                      | Type   | Description |
| ----------------------------------------- | ------ | ----------- |
| spaceId<mark style="color:red;">\*</mark> | string | ID of space |

#### Query Parameters

| Name                                   | Type   | Description                                                                                                                                                                                      |
| -------------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| tags<mark style="color:red;">\*</mark> | string | Comma separated list of tags. The query at the end of the url address should look like this: ?tags=tag1,tag2. Such query would select all the rules where tag array contains both tag1 and tag2. |

#### Headers

| Name                                            | Type   | Description        |
| ----------------------------------------------- | ------ | ------------------ |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer \<API\_KEY> |

{% tabs %}
{% tab title="200: OK Returns an array of rules." %}
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

{% tab title="401: Unauthorized API key missing." %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endtab %}
{% endtabs %}

## Add tags to rule

<mark style="color:purple;">`PATCH`</mark> `https://api.decisionrules.io/api/tags/rules/:spaceId/:ruleId/:version?`

If you specify the version, the tag/tags will be added to the specified version. If the version is not specified, the tag/tags will be added to all the versions with given rule ID.

#### Path Parameters

| Name                                      | Type   | Description     |
| ----------------------------------------- | ------ | --------------- |
| spaceId<mark style="color:red;">\*</mark> | string | ID of space     |
| ruleId<mark style="color:red;">\*</mark>  | string | ID of rule      |
| version                                   | string | Version of rule |

#### Headers

| Name                                            | Type   | Description        |
| ----------------------------------------------- | ------ | ------------------ |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer \<API\_KEY> |

#### Request Body

| Name                                   | Type  | Description          |
| -------------------------------------- | ----- | -------------------- |
| body<mark style="color:red;">\*</mark> | array | Array of tags to add |

{% tabs %}
{% tab title="200: OK " %}
```javascript
{message: 'ok'}
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

{% tab title="401: Unauthorized API key missing." %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endtab %}
{% endtabs %}

## Delete tags from rule

<mark style="color:red;">`DELETE`</mark> `https://api.decisionrules.io/api/tags/rules/:spaceId/:ruleId/:version?`

If you specify the version, the tag/tags will be deleted from the specified version. If the version is not specified, the tag/tags will be removed from all the versions with given rule ID.

#### Path Parameters

| Name                                      | Type   | Description     |
| ----------------------------------------- | ------ | --------------- |
| spaceId<mark style="color:red;">\*</mark> | string | ID of space     |
| ruleId<mark style="color:red;">\*</mark>  | string | ID of rule      |
| version                                   | string | Version of rule |

#### Query Parameters

| Name                                   | Type   | Description                                                                                                  |
| -------------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------ |
| tags<mark style="color:red;">\*</mark> | string | Comma separated list of tags. The query at the end of the url address should look like this: ?tags=tag1,tag2 |

#### Headers

| Name                                            | Type   | Description        |
| ----------------------------------------------- | ------ | ------------------ |
| Authorization<mark style="color:red;">\*</mark> | string | Bearer \<API\_KEY> |

{% tabs %}
{% tab title="200: OK " %}
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

{% tab title="401: Unauthorized API key missing." %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endtab %}
{% endtabs %}
