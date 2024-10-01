# File Structure of JSON Format

Decision Tables exported or imported in JSON format require certain mandatory attributes to maintain a consistent structure. Below are the required and optional components of a decision table JSON file.

### Mandatory Elements

* `name`**:** name of the decision table;
* `type`**:** always `"decision-table"` for decision tables;
* `status`**:** the current[ state of the decision table](../../other/rule-state.md)  ("`published`" or "`pending`");
* `inputSchema`**:** describes the [input variables](../input-and-output/) of the decision table. Each variable should be defined as an object, which can hold different attributes or substructures;
* `outputSchema`**:** describes the expected [output variables](../input-and-output/) from the decision table
* `decisionTable`**:**  contains the rule itself:
  * `columns`: defines the [different types of columns](../decision-table-designer.md#column-types-and-table-structure) in the table, such as input (conditions), calculation, and result columns;
    * `condition`: condition columns specify the criteria that inputs need to meet;
    * `calculation`: columns that calculate values based on the input or other conditions;
    * `columnOutput`: defines the result of the decision table based on the calculations or conditions;
  * `rows`:[ rows](../decision-table-designer.md#row) of the decision table;
    * `cells`: each row contains cells, which correspond to the column definitions, and they hold specific values or functions applied to the data;
    * `active:` a boolean attribute that defines if a [row is active](../decision-table-designer.md#deactivate-and-activate-row) (true) or not;

### Optional Elements

* `description`: a textual description of the decision table;
* `ruleAlias`: an [alias for the rule](../../other/rule-alias.md). If this is left as an empty string, the system will generate one automatically upon import;
* `createdIn`: the date and time of the rule's creation, following the ISO 8601 format. If left empty, this will be generated automatically upon import;
* `lastUpdate`: the date and time of the last update, also in ISO 8601 format. If empty, it will be automatically generated upon import;
* `tags`**:** an array containing[ tags](../../other/tagging.md) for categorizing the rule. It may be an empty array;
* `visualData`: contains information about the visual presentation of the columns, including:
  * `columns`: an array where each object contains:
    * `columnId`: the unique identifier for the column (string);
    * `width`: the width of the column in the UI (number);
* `auditLog`: specifies the [audit logging](../../business-intelligence/audit-logs.md) configuration;
  * `active`: defines whether audit logging is active;
  * `debug`: contains a nested attribute `active`, which controls whether debug logging is enabled;
  * `ttl`: time to live (in days) for the audit logs (optional, with a default of 14 days).

### Examples

#### Minimal File Structure Example:

```json
{
    "name": "",
    "description": "",
    "type": "decision-table",
    "status": "",
    "inputSchema": {},
    "outputSchema": {},
    "decisionTable": {
        "columns": [],
        "rows": []
    }
}
```

#### File Structure Example:

{% code lineNumbers="true" %}
```json
{
    "name": "Example table",
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
                    "name": "Condition",
                    "definition": {
                        "content": "input",
                        "type": "INPUT_VARIABLE",
                        "valid": false
                    }
                },
                "columnId": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                "type": "input",
                "alias": "col-green-elephant"
            },
            {
                "calculation": {
                    "variable": "calcVar",
                    "name": "Calculation"
                },
                "columnId": "a93899f3-d75b-8f64-3b05-781bc42e836a",
                "type": "calc",
                "alias": "col-turquoise-eagle"
            },
            {
                "columnOutput": {
                    "type": "simple",
                    "outputVariable": "output",
                    "name": "Result"
                },
                "columnId": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                "type": "output",
                "alias": "col-violet-lion"
            }
        ],
        "rows": [
            {
                "active": true,
                "cells": [
                    {
                        "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                        "scalarCondition": {
                            "operator": "function",
                            "value": {
                                "functionName": "EQUAL",
                                "parameters": [
                                    1,
                                    "1"
                                ]
                            },
                            "type": "function",
                            "stringValue": "EQ(1, \"1\")"
                        },
                        "type": "input"
                    },
                    {
                        "column": "a93899f3-d75b-8f64-3b05-781bc42e836a",
                        "outputScalarValue": {
                            "value": {
                                "functionName": "ABS",
                                "parameters": [
                                    {
                                        "functionName": "MINUS_CHAR",
                                        "parameters": [
                                            2
                                        ]
                                    }
                                ]
                            },
                            "type": "function",
                            "stringValue": "ABS(-2)"
                        },
                        "type": "calc"
                    },
                    {
                        "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                        "outputScalarValue": {
                            "type": "function",
                            "value": "\"1 equals '1', and absolute value of -2 is {calcVar}\"",
                            "stringValue": "\"1 equals '1', and absolute value of -2 is {calcVar}\""
                        },
                        "type": "output"
                    }
                ]
            },
            {
                "active": true,
                "cells": [
                    {
                        "column": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                        "scalarCondition": {
                            "operator": "function",
                            "value": {
                                "functionName": "LESS",
                                "parameters": [
                                    2,
                                    6
                                ]
                            },
                            "type": "function",
                            "stringValue": "LT(2, 6)"
                        },
                        "type": "input"
                    },
                    {
                        "column": "a93899f3-d75b-8f64-3b05-781bc42e836a",
                        "outputScalarValue": {
                            "value": {
                                "functionName": "AVG",
                                "parameters": [
                                    10,
                                    16,
                                    80,
                                    5
                                ]
                            },
                            "type": "function",
                            "stringValue": "AVG(10, 16, 80, 5)"
                        },
                        "type": "calc"
                    },
                    {
                        "column": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                        "outputScalarValue": {
                            "value": "\"2 is less than 6, and average of 10, 16, 80 and 5 is {calcVar}\"",
                            "type": "function",
                            "stringValue": "\"2 is less than 6, and average of 10, 16, 80 and 5 is {calcVar}\""
                        },
                        "type": "output"
                    }
                ]
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
    "visualData": {
        "columns": [
            {
                "columnId": "2e46eb73-de05-51bc-5913-4b261bbe2069",
                "width": 708
            },
            {
                "columnId": "ec57bb7c-8e90-4aee-da49-17b607a6b09a",
                "width": 297
            },
            {
                "columnId": "a93899f3-d75b-8f64-3b05-781bc42e836a",
                "width": 466
            }
        ]
    },
    "ruleAlias": "comprehensive-vole",
    "createdIn": "2024-09-25T10:01:54.140Z",
    "lastUpdate": "2024-09-25T11:10:12.365Z",
    "tags": []
}
```
{% endcode %}

### Conclusion

When working with Decision Tables in JSON format, it's crucial to adhere to the structure, ensuring that mandatory elements like `name`, `type`, `status`, and schemas are defined. Optional elements such as descriptions, audit logs, and visual data offer flexibility and can improve clarity and management. By following these guidelines, users can maintain a consistent and reliable Decision Table structure that ensures smooth data handling and integration.
