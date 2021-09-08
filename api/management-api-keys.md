# Management API

{% api-method method="get" host="https://api.decisionrules.io" path="/api/rule/:ruleId" %}
{% api-method-summary %}
Get rule by Id
{% endapi-method-summary %}

{% api-method-description %}
This endpoint allows you to get JSON format of rule by ruleId.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="ruleId" type="string" required=true %}
Unique rule ID that is common to all rule versions
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Authorization" type="string" required=true %}
Bearer &lt;Management API key&gt;
{% endapi-method-parameter %}
{% endapi-method-headers %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

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
{% endapi-method-response-example %}

{% api-method-response-example httpCode=400 %}
{% api-method-response-example-description %}
Invalid API key or ruleId
{% endapi-method-response-example-description %}

```
Error: This rule belongs to another user OR rule not found
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

{% hint style="warning" %}
If the rule has multiple versions, you get the JSON format of the latest rule version.
{% endhint %}

{% api-method method="get" host="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" %}
{% api-method-summary %}
Get rule by Id and Version
{% endapi-method-summary %}

{% api-method-description %}
This endpoint allows you to get JSON format of rule by ruleId and vesrsion.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="ruleId" type="string" required=true %}
Unique rule ID that is common to all rule versions
{% endapi-method-parameter %}

{% api-method-parameter name="version" type="integer" required=true %}
Business rule version.
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Authorization" type="string" required=true %}
Bearer &lt;Manegement API key&gt;
{% endapi-method-parameter %}
{% endapi-method-headers %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

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
{% endapi-method-response-example %}

{% api-method-response-example httpCode=400 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
Error: This rule belongs to another user OR rule not found
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

{% api-method method="put" host="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" %}
{% api-method-summary %}
Update rule by Id and Version
{% endapi-method-summary %}

{% api-method-description %}
This endpoint allows you to overwrite a rule. 
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="rule Id" type="string" required=true %}
ID of Rule
{% endapi-method-parameter %}

{% api-method-parameter name="version" type="integer" required=true %}
Version of Rule
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Authorization" type="string" required=true %}
Bearer &lt;Management API key&gt;
{% endapi-method-parameter %}
{% endapi-method-headers %}

{% api-method-body-parameters %}
{% api-method-parameter name="body" type="object" required=true %}
JSON format of a  rule
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}
The rule has been updated
{% endapi-method-response-example-description %}

```

```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=400 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
TypeError: rule.decisionTable.rows is not iterable
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

{% api-method method="delete" host="https://api.decisionrules.io" path="/api/rule/:ruleId/:version" %}
{% api-method-summary %}
Delete a rule by Id and Version
{% endapi-method-summary %}

{% api-method-description %}
This endpoint allows you to delete a rule by ruleId and version of the rule.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="ruleId" type="string" required=true %}
ID of rule
{% endapi-method-parameter %}

{% api-method-parameter name="version" type="integer" required=true %}
Version of Rule
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Authorization" type="string" required=true %}
Bearer &lt;Management API key&gt;
{% endapi-method-parameter %}
{% endapi-method-headers %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```

```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=400 %}
{% api-method-response-example-description %}
Invalid API key or ruleId
{% endapi-method-response-example-description %}

```
Error: This rule belongs to another user OR rule not found
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

{% api-method method="post" host="https://api.decisionrules.io" path="/api/rule/:spaceId" %}
{% api-method-summary %}
Create rule for Space
{% endapi-method-summary %}

{% api-method-description %}
This endpoint allows you to create a rule 
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="spaceId" type="string" required=true %}
Id of Space
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Authorization" type="string" required=true %}
Bearer &lt;Management API key&gt;
{% endapi-method-parameter %}
{% endapi-method-headers %}

{% api-method-body-parameters %}
{% api-method-parameter name="body" type="object" required=true %}
JSON format of a rule
{% endapi-method-parameter %}
{% endapi-method-body-parameters %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}
Change has been made
{% endapi-method-response-example-description %}

```

```
{% endapi-method-response-example %}

{% api-method-response-example httpCode=400 %}
{% api-method-response-example-description %}
Invalid API key or ruleId
{% endapi-method-response-example-description %}

```

```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

{% api-method method="get" host="https://api.decisionrules.io" path="/api/info/space/:spaceId" %}
{% api-method-summary %}
Get rules for Space
{% endapi-method-summary %}

{% api-method-description %}
This endpoint allows you to get JSON format with all rules in the Space.
{% endapi-method-description %}

{% api-method-spec %}
{% api-method-request %}
{% api-method-path-parameters %}
{% api-method-parameter name="spaceId" type="string" required=true %}
ID of space
{% endapi-method-parameter %}
{% endapi-method-path-parameters %}

{% api-method-headers %}
{% api-method-parameter name="Authorization" type="string" required=true %}
Bearer &lt;Management API key&gt;
{% endapi-method-parameter %}
{% endapi-method-headers %}
{% endapi-method-request %}

{% api-method-response %}
{% api-method-response-example httpCode=200 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

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
{% endapi-method-response-example %}

{% api-method-response-example httpCode=400 %}
{% api-method-response-example-description %}

{% endapi-method-response-example-description %}

```
Wrong spaceId!
```
{% endapi-method-response-example %}
{% endapi-method-response %}
{% endapi-method-spec %}
{% endapi-method %}

