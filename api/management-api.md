---
description: >-
  The Management API is a secure REST API that provides read/write access to
  your rules and spaces.
cover: >-
  https://images.unsplash.com/photo-1623282033815-40b05d96c903?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwxfHxBUEl8ZW58MHx8fHwxNjM0NzM3NjYx&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Management API

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version?" method="get" summary="Get rule" %}
{% swagger-description %}
If the version is not specified, get rule with the latest version.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" required="true" %}
Unique rule ID that is common to all rule versions
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

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="put" summary="Update rule" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="rule Id" type="string" required="false" %}
ID of Rule
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" required="false" %}
Version of Rule
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="false" %}
Bearer
{% endswagger-parameter %}

{% swagger-parameter in="body" name="body" type="object" required="false" %}
JSON format of a rule
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

#### Request example

{% tabs %}
{% tab title="Request" %}
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
    "tags": ["newTagName"]
}   
```
{% endtab %}
{% endtabs %}

{% swagger method="put" path="/api/rule/status/{ruleId}/{status}" baseUrl="https://api.decisionrules.io" summary="Update rule status" %}
{% swagger-description %}
Changes rule status from 

<mark style="color:orange;">

pending

</mark>

 to 

<mark style="color:green;">

published

</mark>

 and vice versa.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" required="true" %}
rule id
{% endswagger-parameter %}

{% swagger-parameter in="path" name="status" required="true" %}
<mark style="color:green;">

pending

</mark>

 XOR 

<mark style="color:orange;">

published

</mark>
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer MANAGEMENT_API_KEY
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

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="delete" summary="Delete rule" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" required="true" %}
ID of rule
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" required="true" %}
Version of Rule
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



{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:spaceId" method="post" summary="Create rule" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" required="true" %}
Id of Space
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-parameter in="body" name="body" type="object" required="true" %}
JSON format of a rule
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

#### Request example

{% tabs %}
{% tab title="Request" %}
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
{% endtab %}
{% endtabs %}



## Spaces

{% swagger baseUrl="https://api.decisionrules.io" path="/api/space/:spaceId" method="get" summary="Get all rules in space" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" required="true" %}
ID of space
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer
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

## Tag

{% swagger method="get" path="/api/tags/rules/:spaceId/?tags=tagName,anotherTagName" baseUrl="https://api.decisionrules.io" summary="Get rules by tag/tags" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="query" name="tags" type="string" required="true" %}
Comma separated list of tags. The query at the end of the url address should look like this: ?tags=tag1,tag2. Such query would select all the rules where tag array contains both tag1 and tag2.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer
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

{% swagger method="patch" path="/api/tags/rules/:spaceId/:ruleId/:version?" baseUrl="https://api.decisionrules.io" summary="Add tag/tags to rule" %}
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
Bearer
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

#### Request example

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



{% swagger method="delete" path="/api/tags/rules/:spaceId/:ruleId/:version?" baseUrl="https://api.decisionrules.io" summary="Delete tag/tags from rule" %}
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
Bearer
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

## Rule Flow



{% swagger method="get" path="/api/rule-flow/:ruleFlowId/:version?" baseUrl="https://api.decisionrules.io" summary="Get Rule Flow" %}
{% swagger-description %}
If the version is not specified, get Rule Flow with the latest version.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleFlowId" required="true" type="String" %}
Id of Rule Flow
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



{% swagger method="put" path="/api/rule-flow/:ruleFlowId/version" baseUrl="https://api.decisionrules.io" summary="Update Rule Flow" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="ruleFlowId" type="String" required="true" %}
Id of Rule Flow
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

#### Request example

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



{% swagger method="delete" path="/api/rule-flow/:ruleFlowId/:version" baseUrl="https://api.decisionrules.io" summary="Delete Rule Flow" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="ruleFlowId" type="String" required="true" %}
Id of Rule Flow
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

#### Request example

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

{% swagger method="get" path="/api/rule-flow/export/:ruleFlowId/:version?" baseUrl="https://api.decisionrules.io" summary="Export Rule Flow with all rules" %}
{% swagger-description %}
Export Rule Flow with all rules. If the version is not specified, export Rule Flow with the latest version.
{% endswagger-description %}

{% swagger-parameter in="path" required="true" name="ruleFlowId" type="String" %}

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

{% swagger method="post" path="/rule-flow/import" baseUrl="https://api.decisionrules.io" summary="Import Rule Flow with all rules" %}
{% swagger-description %}
Import Rule Flow with all rules. If no query parameters are set, then will be created new Rule Flow. If it is set new-version query parameter, then will be created a new version of the targeted Rule Flow. If it is set overwrite and version, then will be overwritten target Rule Flow with a specific version.
{% endswagger-description %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer
{% endswagger-parameter %}

{% swagger-parameter in="query" name="new-version" type="String" %}
Id of target Rule Flow
{% endswagger-parameter %}

{% swagger-parameter in="query" name="overwrite" type="String" %}
Id of target Rule Flow
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

```json
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
