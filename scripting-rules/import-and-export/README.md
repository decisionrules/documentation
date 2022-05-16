# Import & Export Scripting Rules

## How to import and export scripting rules?

{% content-ref url="export-scripting-rule.md" %}
[export-scripting-rule.md](export-scripting-rule.md)
{% endcontent-ref %}

{% content-ref url="import-scripting-rule.md" %}
[import-scripting-rule.md](import-scripting-rule.md)
{% endcontent-ref %}

### File Structure

Imported & Exported files need to have some mandatory structural information:

* **name:** name of the scripting rule
* **description:** description of the scripting rule
* **type:** type of the scripting rule
* **status:** [status of the scripting rule](../../import-and-export/broken-reference/)
* **inputSchema:** input schema of the scripting rule
* **outputSchema:** output schema of the scripting rule
* **script:** rules of the scripting rule

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
    "script": ""
}
```

#### File Structure Example:

```javascript
{
    "name": "Multiply (Sample Script)",
    "description": "Sample scripting rule",
    "type": "complex-rule",
    "status": "published",
    "inputSchema": {
        "value1": {},
        "value2": {}
    },
    "outputSchema": {
        "result": {}
    },
    "script": "/* \n    1.  Input variables\n    Input body is set in input variable \n*/\nlet a = input.value1;\nlet b = input.value2;\n\n/*\n    2.  Define simple \"multiply\" function\n*/\nfunction multiply(a, b) {\n    return a * b;\n}\n\n/*\n    3.  Execute multiply function and store value result variable\n*/\nlet resultMultiply = multiply(a, b);\n\n/*\n    4.  Set output model which is returned in REST API\n*/\noutput.result = resultMultiply;\n\n/*\n    Optionally: It is possible print values to console\n*/\nconsole.log('Result multiply:', resultMultiply);\n\n/*\n    5.  Return output  \n*/\nreturn output;"
}
```
