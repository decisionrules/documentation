# Python

## [decisionrulespy on PyPi](https://pypi.org/project/decisionrulespy/)

##  ![](../../.gitbook/assets/python-3-1-.svg) 

## DecisionRulespy

Simple python library that allows you to easily connect to [Decisionrules.io](https://decisionrules.io/) from your python application.

## Where do I get API key?

You can create your API key here: [https://app.decisionrules.io/api-keys](https://app.decisionrules.io/api-keys)

## Supported kwargs

* ruleId: string
* api\_key: string
* input\_data: dics
* version: string
* geoloc: string

Version and Geolocation are optional parameters. If you left out the version then you will automatically get the result of your latest version deployed on DecisionRules dashboard.

If you omit geolocation your request will be computed on EU1 \(Ireland\).

We offer these values:

* eu1: Ireland
* eu2: Sweden
* us1: Virginia
* us2: North California

## Simple usage demo

```python
import decisionrules

decisionrules.init("API_KEY_HERE", "GEOLOCATION_HERE")

input_data = {"data": {"day": "today"}}

resp1 = decisionrules.solver("RULE_ID_HERE", input_data, "VERSION_HERE")

resp2 = decisionrules.solver("RULE_ID_HERE", input_data)

print(resp1)
print(resp2[0]['result'])
```

