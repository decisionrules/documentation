---
description: >-
  This editor is designed for experienced users familiar with the structure of
  JSON objects.
---

# JSON Editor

## Working with the JSON Editor

<figure><img src="../../../.gitbook/assets/json editor.png" alt=""><figcaption><p>JSON Editor</p></figcaption></figure>

{% hint style="danger" %}
After making any changes to the input/output model, be sure to save them by clicking the **Save** button in the bottom-right corner. Please note that all changes apply only to the current version of the rule.
{% endhint %}

{% hint style="info" %}
There are no limitations when creating input/output models. A model can have an unlimited number of root objects and child objects.
{% endhint %}

### Creating a Model

The model follows a tree structure written in JSON format. Root objects can contain children, but only leaf objects (objects without children) can be selected as variables.

To create a leaf object, use the following format:

Object with empty `{}`:

```javascript
"objectName": {}
```

{% hint style="warning" %}
Arrays and values are not allowed.
{% endhint %}

#### Example of a Simple Model with Leaves Only:

```javascript
{
    "distance": {},
    "tariff": {},
    "weight": {},
    "longestSide": {}
}
```

#### Example of a Complex Model:

```javascript
{
  "delivery": {
    "distance": {
      "car": {},
      "ship": {},
      "plane": {}
    },
    "tariff": {}
  },
  "package": {
    "weight": {},
    "longestSide": {}
  }
}
```

### Beautify Code

To beautify the code for better readability, right-click the JSON model and choose the **Format Document** option.

<figure><img src="../../../.gitbook/assets/Beautify code.gif" alt=""><figcaption><p>Beautify code</p></figcaption></figure>

{% hint style="info" %}
This functionality is particularly useful when copying and pasting JSON from other sources or windows on your device.
{% endhint %}
