# Export & Import Scripting Rules

## File Structure of JSON format

Imported & Exported files need to have some mandatory structural information:

* **name:** name of the script
* **description:** description of the script
* **type:** type of the script
* **status:** [status of the script](../../other/rule-state.md)
* **inputSchema:** input schema of the script
* **outputSchema:** output schema of the script
* **script:** the JavaScript script you wish to run

{% hint style="warning" %}
Type: there are two types:

* "**decision-table**" - for decision tables
* **"decision-tree"** - for decision trees
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
    "script": {}
}
```

#### File Structure Example:

```javascript
{
    "name": "Secret Script Import",
    "description": "Sample scripting rule",
    "inputSchema": {
        "value1": {},
        "value2": {}
    },
    "outputSchema": {
        "result": {}
    },
    "script": "/* \n    log('Hello, World!') */",
    "type": "complex-rule",
    "status": "published",
    "auditLog": {
        "active": false,
        "debug": {
            "active": false
        },
        "ttl": 14
    },
    "tags": [
        "Client"
    ],
    "createdIn": "2023-01-05T13:57:01.600Z",
    "lastUpdate": "2023-01-05T13:57:01.600Z",
    "ruleAlias": "chosen-bovid"
}
```
