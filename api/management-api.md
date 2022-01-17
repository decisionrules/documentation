---
description: >-
  The Management API is a secure REST API that provides read/write access to
  your rules and spaces.
cover: >-
  https://images.unsplash.com/photo-1623282033815-40b05d96c903?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwxfHxBUEl8ZW58MHx8fHwxNjM0NzM3NjYx&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Management API

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId" method="get" summary="Get Rule by Id" %}
{% swagger-description %}
This endpoint allows you to get JSON format of rule by ruleId.
{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" %}
Unique rule ID that is common to all rule versions
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" %}
Bearer <Management API key>
{% endswagger-parameter %}

{% swagger-response status="200" description=""Tags" property may OR may not exist." %}
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

{% hint style="success" %}
If the rule has multiple versions, you get the JSON format of the latest rule version.
{% endhint %}

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="get" summary="Get Rule by Id and Version" %}
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

{% swagger-response status="200" description=""Tags" property may OR may not exist." %}
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

{% swagger baseUrl="https://api.decisionrules.io" path="/api/space/:spaceId" method="get" summary="Get All Rules in Space" %}
{% swagger-description %}
This endpoint allows you to get JSON format with all rules in the Space.
{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" %}
ID of space
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" %}
Bearer <Management API key>
{% endswagger-parameter %}

{% swagger-response status="200" description=""Tags" property may OR may not exist." %}
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

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="put" summary="Update Rule by Id and Version" %}
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
        "lastUpdate": "2021-09-08T11:40:59.398Z",
        "tags": ["newTagName"]
    }
        
}
```

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="delete" summary="Delete Rule by Id and Version" %}
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

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:spaceId" method="post" summary="Create Rule for Space" %}
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
        "lastUpdate": "2021-09-08T11:40:59.398Z",
        "tags": ["tagName"]
    }
        
}
```

## Tag API

{% swagger method="get" path="" baseUrl="https://api.decisionrules.io/api/tags/rules/:spaceId" summary="Get rules by tag/tags" %}
{% swagger-description %}
This endpoint allows you to get all rules with certain tags.
{% endswagger-description %}

{% swagger-parameter in="query" name="tags" type="string" required="true" %}
Comma separated list of tags. The query at the end of the url address should look like this: ?tags=tag1,tag2. Such query would select all the rules where tag array contains both tag1 and tag2.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer <Management API key>
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

{% swagger method="patch" path="" baseUrl="https://api.decisionrules.io/api/tags/rules/:spaceId/:ruleId/:version?" summary="Add tag/tags to rule" %}
{% swagger-description %}
If you specify the version, the tag/tags will be added to the specified version. If the version is not specified, the tag/tags will be added to all the versions with given rule ID.
{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" required="true" %}
ID of space
{% endswagger-parameter %}

{% swagger-parameter in="path" name="ruleId" type="string" required="true" %}
ID of rule
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="string" %}
Version of rule
{% endswagger-parameter %}

{% swagger-parameter in="body" type="array" name="body" required="true" %}
Array of tags to add
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer <Management API key>
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

{% swagger method="delete" path="" baseUrl="https://api.decisionrules.io/api/tags/rules/:spaceId/:ruleId/:version?" summary="Delete tag/tags from rule" %}
{% swagger-description %}
If you specify the version, the tag/tags will be deleted from the specified version. If the version is not specified, the tag/tags will be removed from all the versions with given rule ID.
{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" required="true" %}
ID of space
{% endswagger-parameter %}

{% swagger-parameter in="path" name="ruleId" type="string" required="true" %}
ID of rule
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="string" %}
Version of rule
{% endswagger-parameter %}

{% swagger-parameter in="query" name="tags" type="string" required="true" %}
Comma separated list of tags. The query at the end of the url address should look like this: ?tags=tag1,tag2
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer <Management API key>
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
