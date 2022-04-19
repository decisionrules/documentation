---
description: >-
  The Management API is a secure REST API that provides read/write access to
  your rules and spaces.
cover: >-
  https://images.unsplash.com/photo-1623282033815-40b05d96c903?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwxfHxBUEl8ZW58MHx8fHwxNjM0NzM3NjYx&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Management API

## Decision Rules Management API operations

### Retrieve a rule

This endpoint allows you to retrieve entire rule by ruleId

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId" method="get" summary="Get Rule by Id" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" required="false" %}
Unique rule ID that is common to all rule versions
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="false" %}
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

### Retrieve a rule by Id and Versions

This endpoint allows you to get JSON format of rule by ruleId and version.

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="get" summary="Get Rule by Id and Version" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" required="false" %}
Unique rule ID that is common to all rule versions
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" required="false" %}
Business rule version.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="false" %}
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

### List rules in space

This endpoint allows you to get JSON format with all rules in the Space.

{% swagger baseUrl="https://api.decisionrules.io" path="/api/space/:spaceId" method="get" summary="Get All Rules in Space" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" required="false" %}
ID of space
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="false" %}
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

### Update rule

This endpoint allows you to update or change a rule.

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="put" summary="Update Rule by Id and Version" %}
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

### Update rule status

{% swagger method="put" path="/api/rule/status/{ruleId}/{status}" baseUrl="https://api.decisionrules.io" summary="" %}
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
Returns updated rule.
{% endswagger-response %}

{% swagger-response status="400: Bad Request" description="One or more PATH parameters are invalid" %}
```javascript
{
    // Response
}
```
{% endswagger-response %}
{% endswagger %}

### Delete rule by id and version

This endpoint allows you to delete a rule by ruleId and version of the rule.

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" method="delete" summary="Delete Rule by Id and Version" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" required="false" %}
ID of rule
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" required="false" %}
Version of Rule
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="false" %}
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

### Create rule in space

Creates rule in specific space

{% swagger baseUrl="https://api.decisionrules.io" path="/api/rule/:spaceId" method="post" summary="Create Rule in Space" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="spaceId" type="string" required="false" %}
Id of Space
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="false" %}
Bearer
{% endswagger-parameter %}

{% swagger-parameter in="body" name="body" type="object" required="false" %}
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

### List rules by tag/tags

This endpoint allows you to get all rules with certain tags.

{% swagger method="get" path="" baseUrl="https://api.decisionrules.io/api/tags/rules/:spaceId" summary="Get rules by tag/tags" %}
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

#### Request example

```http
URL
https://api.decisionrules.io/api/tags/rules/:spaceId/?tags=tagName,anotherTagName

Headers:
Content-Type: application/json
Authorization: Bearer DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH
```

### Create tag on rule group or rule version

If you specify the version, the tag/tags will be added to the specified version. If the version is not specified, the tag/tags will be added to all the versions with given rule ID.

{% swagger method="patch" path="" baseUrl="https://api.decisionrules.io/api/tags/rules/:spaceId/:ruleId/:version?" summary="Add tag/tags to rule" %}
{% swagger-description %}

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

```http
URL
https://api.decisionrules.io/api/tags/rules/:spaceId/:ruleId/:version?

Headers:
Content-Type: application/json
Authorization: Bearer DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH

Body:
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

### Delete tag or tags form rule

If you specify the version, the tag/tags will be deleted from the specified version. If the version is not specified, the tag/tags will be removed from all the versions with given rule ID.

{% swagger method="delete" path="" baseUrl="https://api.decisionrules.io/api/tags/rules/:spaceId/:ruleId/:version?" summary="Delete tag/tags from rule" %}
{% swagger-description %}

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

#### Request example

```http
URL
https://api.decisionrules.io/api/tags/rules/:spaceId/:ruleId/:version?/?tags=tagName

Headers:
Content-Type: application/json
Authorization: Bearer DOZpz-h6xnOrKGIINlYvkd9hn41pRR3oG6cqH
```
