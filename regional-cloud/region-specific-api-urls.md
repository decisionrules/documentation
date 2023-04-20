# Region Specific API URLs

## Making API calls on Region Cloud accounts

The process of calling the Rule Solver, Managment API or BI API is the same for region-locked accounts and Global Cloud accounts. The only difference is the endpoint URL.&#x20;

With the Regional Cloud accounts having to **prepend the URL with their respective regional shortcut.**

| Location                                                                                 | Shortcut |           API call URL example          |
| ---------------------------------------------------------------------------------------- | -------: | :-------------------------------------: |
| ![](<../.gitbook/assets/image (190) (1) (1).png>) USA                                    |       us | `https://us.api.decisionrules.io/:PATH` |
| <img src="../.gitbook/assets/european-union.png" alt="" data-size="line"> European Union |       eu | `https://eu.api.decisionrules.io/:PATH` |
| ![](<../.gitbook/assets/image (160) (1).png>) Australia                                  |       au | `https://au.api.decisionrules.io/:PATH` |

### A few examples

#### Solving a rule through the Solver API

Let's say you want to solve a rule on an account registered in the ![](<../.gitbook/assets/image (190) (1) (1).png>)United States. We would follow the instructions in the [Rule Solver API article](../api/rule-solver-api.md#solve-rule) and simply prepend the usual URL with our region's shortcut. In this case 'us', forming the following request:

{% swagger baseUrl="https://us.api.decisionrules.io" path="/rule/solve/:ruleId/:version" method="post" summary="Solve Rule" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="ruleId" type="string" required="true" %}
Unique identifier rule that is common to all rule versions. Instead of rule ID, it is possible to use rule alias.
{% endswagger-parameter %}

{% swagger-parameter in="path" name="version" type="integer" required="false" %}
Business rule version. If the parameter is not filled in, the last published version will be used automatically. See more on versioning.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" type="string" required="true" %}
Bearer <Solver API Key>
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Content-Type" type="string" required="false" %}
application/json
{% endswagger-parameter %}

{% swagger-parameter in="header" name="X-Strategy" type="string" required="false" %}
STANDARD or ARRAY or FIRST\_MATCH.

[More in execution strategies](../other/execution-strategy.md)
{% endswagger-parameter %}

{% swagger-parameter in="body" name="data" type="object" required="false" %}
JSON object that describes the input json data.
{% endswagger-parameter %}

{% swagger-parameter in="body" name="options" type="object" %}
Object specifying solver options.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="X-Correlation-Id" type="string" %}
Correlation ID, in case you would like to set it manually. If not present, correlation ID will be generated automatically. In any case, the correlation ID is returned in the same header of the response.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="X-Debug" type="string" %}
Allows to switch on the debug mode, which is by default off. Set this header to "true" if you want to activate it.
{% endswagger-parameter %}

{% swagger-parameter in="header" name="X-Audit" type="string" %}
Decides whether an audit of the solve should be created and saved. In case you want the audit to be created and saved, input "true".
{% endswagger-parameter %}

{% swagger-parameter in="header" name="X-Audit-Ttl" type="string" %}
A number that dictates after how many days the audit will be deleted. Set to 14 days by default.
{% endswagger-parameter %}

{% swagger-response status="200" description="Rule Solved" %}
```javascript
[
    {
        "car": {
            "price": "666666",
            "seats": {},
            "discount": {
                "low": "2",
                "high": "33"
            }
        }
    },
    {
        "car": {
            "price": "8888888",
            "seats": {},
            "discount": {
                "low": "8",
                "high": "33"
            }
        }
    }
]
```
{% endswagger-response %}

{% swagger-response status="400" description="" %}
```
{
    "error": {
        "message": "Unknown rule or rule version"
    }
}
```
{% endswagger-response %}

{% swagger-response status="401" description="Could not find matching rule" %}
```javascript
{
    "error": {
        "message": "Authentication token missing"
    }
}
```
{% endswagger-response %}
{% endswagger %}

### Updating a rule through the Managment API

Let's say you want to update a rule on an account registered in the <img src="../.gitbook/assets/european-union.png" alt="" data-size="line">EU. We would follow the instructions in the [Management API article](../api/management-api.md#update-rule) and simply prepend the usual URL with our region's shortcut. In this case 'eu', forming the following request:

{% swagger baseUrl="https://eu.api.decisionrules.io" path="/api/rule/:ruleId/:version" method="put" summary="Update rule" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="path" name="rule Id" type="string" required="false" %}
Unique rule ID which is common to all rule versions. 

**You can also use rule alias.**
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

### Getting Console Logs for a rule solve through the Console Logs API

Let's say you want to get console logs for a rule solve on an account registered in ![](<../.gitbook/assets/image (160) (1).png>)Australia. We would follow the instructions in the [Console Logs API article](../api/console-logs-api.md#get-console-logs) and simply prepend the usual URL with our region's shortcut. In this case 'au', forming the following request:

{% swagger method="get" path="/consoleLogs/:correlationId" baseUrl="https://au.api.decisionrules.io" summary="Get Console Logs for a solve" %}
{% swagger-description %}

{% endswagger-description %}

{% swagger-parameter in="query" name="correlationId" required="true" %}
CorrelationId of specific solve
{% endswagger-parameter %}

{% swagger-parameter in="header" name="Authorization" required="true" %}
Bearer <Solver API Key>
{% endswagger-parameter %}
{% endswagger %}
