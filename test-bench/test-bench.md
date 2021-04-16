---
description: Test Bench is used to test rules in Dashboard.
---

# Test Bench

## Testing Decision Table

There are some steps to test your decision table:

1. Select Rule & Version
2. Select API Key
3. Fill Request Body
4. Click on  Solve! button
5. Read Response

### Select Rule & Version

1. The First step is to select the **rule** of what you want to test.
2. After selecting the rule, there are options to set a **version** of the rule. Otherwise, the last version of the rule will be used.

### Select API Key

The Next step is to select some of the created API keys.

{% hint style="warning" %}
If no API key has been created, please follow[ Create API Keys](../api/api-keys.md) instructions before starting Test Bench.
{% endhint %}

### Fill Request Body

The Next step is to fill the **request body**.

#### Example Request Body:

```javascript
{
  "delivery": {
    "tariff": "basic",
    "distance": 50
  },
  "package": {
    "weight": 5
  }
}
```

{% hint style="info" %}
More examples and information are in [Rule Solver](../api/rest-api.md).
{% endhint %}

### Solve!

The Last step is to click on ![](../.gitbook/assets/vystrizek.png) button.

{% hint style="info" %}
After clicking on this button, your specified data \(rule, request body, etc\) is sent to [Rule Solver](../api/rest-api.md).         
{% endhint %}

### Response

After solving, a response will show actual data.

#### Example of Response:

```javascript
[
  {
    "car": {
      "price": 666666,
      "seats": {},
      "discount": {
        "low": 2,
        "high": 33
      }
    }
  }
]
```

{% hint style="info" %}
Example and more information are in [Rule Solver](../api/rest-api.md).
{% endhint %}

## Library Usage example

This component shows how to call [Rule Solver](../api/rest-api.md) in **libraries.**

It is possible to choose one compatible library. After that, the example will be shown in the code block.  
You can copy it or simply click on ![](../.gitbook/assets/screenshoteasy-1-%20%281%29.png) button.

#### **Example of Libary usage:**

![](../.gitbook/assets/screenshoteasy%20%281%29.png)

{% hint style="warning" %}
For this component, you need to have at least one decision table and [API key](../api/api-keys.md).
{% endhint %}



