# Export & Import Rule Flows

## File Structure of JSON format

Imported & Exported files need to have some mandatory structural information:

* **name:** name of the decision table
* **description:** description of the decision table
* **type:** type of the decision table
* **status:** [status of the rule](../../other/rule-state.md)
* **inputSchema:** input schema of the decision table
* **outputSchema:** output schema of the decision table
* **decisionTable:** rules of the decision table

{% hint style="warning" %}
Type: there are two types:

* "**decision-table**" - for decision tables
* "**complex-rule**" - for scripting rules
{% endhint %}

#### Minimal File Structure Example:

```javascript
{
    "name": "",
    "description": "",
    "type": "",
    "status": "",
    "inputSchema": {
    },
    "outputSchema": {
    },
    "decisionTable": {
        "columns": [
        ],
        "rows": [
        ]
    }
}
```

#### File Structure Example:

```javascript
{
    "name": "Sample rule",
    "description": "Sample package delivery rule",
    "type": "decision-table",
    "status": "published",
    "inputSchema": {
        "delivery": {
            "distance": {},
            "tariff": {}
        },
        "package": {
            "weight": {},
            "longestSide": {}
        }
    },
    "outputSchema": {
        "price": {}
    },
    "decisionTable": {
        "columns": [
            {
                "condition": {
                    "type": "simple",
                    "inputVariable": "delivery.tariff",
                    "name": "Delivery tariff"
                },
                "columnId": "6849dfec-7621-93af-1e40-21c60bccafe0",
                "type": "input"
            },
            {
                "columnOutput": {
                    "type": "simple",
                    "outputVariable": "price",
                    "name": "Delivery Price"
                },
                "columnId": "d88e08fc-b179-7ce7-5567-7ebd06c6e9d1",
                "type": "output"
            }
        ],
        "rows": [
            {
                "cells": [
                    {
                        "column": "6849dfec-7621-93af-1e40-21c60bccafe0",
                        "scalarCondition": {
                            "value": "basic",
                            "operator": "="
                        },
                        "type": "input"
                    },
                    {
                        "column": "d88e08fc-b179-7ce7-5567-7ebd06c6e9d1",
                        "outputScalarValue": {
                            "value": "150"
                        },
                        "type": "output"
                    }
                ]
            }
        ]
    }
}
```
