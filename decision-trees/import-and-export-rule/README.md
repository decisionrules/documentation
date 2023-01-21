# Export & Import Decision Trees

## File Structure of JSON format

Imported & Exported files need to have some mandatory structural information:

* **name:** name of the decision tree
* **description:** description of the decision tree
* **type:** type of the decision tree
* **status:** [status of the decision tree](../../other/rule-state.md)
* **inputSchema:** input schema of the decision tree
* **outputSchema:** output schema of the decision tree
* **nodes:** rules of the decision tree

{% hint style="warning" %}
Type: there are two types:

* "**decision-table**" - for decision tables
* **"decision-tree"** - for decision trees
* "**complex-rule**" - for scripting rules
{% endhint %}

#### Minimal File Structure Example:

```json
{
    "name": "",
    "description": "",
    "type": "",
    "status": "",
    "inputSchema": {
    },
    "outputSchema": {
    },
    "nodes": []
}
```

#### File Structure Example:

```json
{
    "type": "decision-tree",
    "name": "Sample Tree",
    "description": "Sample Decision Tree description",
    "inputSchema": {
        "package": {
            "weight": {}
        }
    },
    "outputSchema": {
        "price": {},
        "currency": {},
        "deliveryInHours": {}
    },
    "status": "published",
    "tags": [],
    "nodes": [
        {
            "id": "eb9c8cdf-f1a4-e22b-7a78-9956dfc51f32",
            "operandText": "If",
            "type": "if",
            "nodes": [
                {
                    "id": "12680fa0-4269-f594-05f5-7fb41ff66aec",
                    "type": "condition",
                    "scalarCondition": {
                        "operator": "between",
                        "value": [
                            "10",
                            "30"
                        ],
                        "type": "general"
                    },
                    "modelVariablePath": "package.weight"
                },
                {
                    "id": "ba6cef9b-9e3f-9d17-9348-4b5ffdb2811b",
                    "operandText": "Then",
                    "type": "then",
                    "nodes": [
                        {
                            "id": "77dec4e9-0f42-a752-266a-8f5ea0611971",
                            "type": "result",
                            "outputScalarValue": {
                                "value": "28",
                                "type": "common"
                            },
                            "modelVariablePath": "price"
                        },
                        {
                            "id": "f8cc604e-b453-fb35-5594-5e98eaae1743",
                            "type": "result",
                            "outputScalarValue": {
                                "value": "USD",
                                "type": "common"
                            },
                            "modelVariablePath": "currency"
                        },
                        {
                            "id": "433b7386-2389-d2a5-45c0-e87f50bbe3e9",
                            "type": "result",
                            "outputScalarValue": {
                                "value": "24 Hours",
                                "type": "common"
                            },
                            "modelVariablePath": "deliveryInHours"
                        }
                    ]
                }
            ]
        },
        {
            "id": "e899c5ab-20cd-ce60-6cd8-ca1d2c19a27d",
            "operandText": "Else",
            "type": "else",
            "nodes": [
                {
                    "id": "505af7be-7c5d-710c-b303-6b094a758653",
                    "operandText": "Then",
                    "type": "then",
                    "nodes": [
                        {
                            "id": "b38ba39e-34ae-4957-d6ce-5ca937ef4076",
                            "type": "result",
                            "outputScalarValue": {
                                "value": "99",
                                "type": "common"
                            },
                            "modelVariablePath": "price"
                        },
                        {
                            "id": "1834f163-48b7-c982-923a-98db7849ddc3",
                            "type": "result",
                            "outputScalarValue": {
                                "value": "USD",
                                "type": "common"
                            },
                            "modelVariablePath": "currency"
                        },
                        {
                            "id": "ec058c7a-6d7b-79f5-727c-6120f331c835",
                            "type": "result",
                            "outputScalarValue": {
                                "value": "48 Hours",
                                "type": "common"
                            },
                            "modelVariablePath": "deliveryInHours"
                        }
                    ]
                }
            ]
        }
    ],
    "auditLog": {
        "active": false,
        "debug": {
            "active": false
        },
        "ttl": 14
    },
    "createdIn": "2023-01-09T15:22:58.235Z",
    "lastUpdate": "2023-01-09T15:23:35.840Z",
    "ruleAlias": "hollow-roundworm"
}
```
