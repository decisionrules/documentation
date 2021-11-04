# Management API

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId" method="get" summary="Get rule by Id" %}
{% swagger-description %}
This endpoint allows you to get JSON format of rule by ruleId.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" %}
Unique rule ID that is common to all rule versions
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" %}
Bearer <Management API key>
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
  "lastUpdate": "2021-09-03T06:35:42.663Z"
}
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
If the rule has multiple versions, you get the JSON format of the latest rule version.
{% endhint %}

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="get" summary="Get rule by Id and Version" %}
{% swagger-description %}
This endpoint allows you to get JSON format of rule by ruleId and version.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" %}
Unique rule ID that is common to all rule versions
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" %}
Business rule version.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" %}
Bearer <Manegement API key>
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
  "lastUpdate": "2021-09-03T06:35:42.663Z"
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

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="put" summary="Update rule by Id and Version" %}
{% swagger-description %}
This endpoint allows you to overwrite a rule. 
{% endswagger-description %}

{% swagger-parameter in="path" name="rule Id" type="string" %}
ID of Rule
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" %}
Version of Rule
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" %}
Bearer <Management API key>
{% endswagger-parameter %}

{% swagger-parameter in="body" name="body" type="object" %}
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

```http
URL
https://api.decisionrules.io/api/rule/:ruleId/:version

Headers:
Content-Type: application/json
Authorization: Bearer DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH
```

```typescript
{
    "body": {
        // INPUT OBJECT
    }
}
```

```typescript
{
    "body": {
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
        "lastUpdate": "2021-09-08T11:40:59.398Z"
    }
        
}
```

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="delete" summary="Delete a rule by Id and Version" %}
{% swagger-description %}
This endpoint allows you to delete a rule by ruleId and version of the rule.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" %}
ID of rule
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" %}
Version of Rule
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" %}
Bearer <Management API key>
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

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:spaceId" method="post" summary="Create rule for Space" %}
{% swagger-description %}
This endpoint allows you to create a rule 
{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" %}
Id of Space
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" %}
Bearer <Management API key>
{% endswagger-parameter %}

{% swagger-parameter in="body" name="body" type="object" %}
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

```http
URL
https://api.decisionrules.io/api/rule/:ruleId/:version

Headers:
Content-Type: application/json
Authorization: Bearer DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH
```

```typescript
{
    "body": {
        // INPUT OBJECT
    }
}
```

```typescript
{
    "body": {
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
        "lastUpdate": "2021-09-08T11:40:59.398Z"
    }
        
}
```

{% swagger baseUrl="https://api.decisionrules.io" path="/api/space/:spaceId" method="get" summary="Get rules for Space" %}
{% swagger-description %}
This endpoint allows you to get JSON format with all rules in the Space.
{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" %}
ID of space
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" %}
Bearer <Management API key>
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
    "type": "Decision Table"
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
