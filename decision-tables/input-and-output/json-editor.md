---
description: >-
  Editor for experienced users who have experience with the structure of JSON
  objects.
---

# JSON Editor

## Working with the JSON Editor

![](../../.gitbook/assets/code-editor.png)

### Applying changes

1. For every changes applied, there is a need to save them.
2. If the model is changed, ![](../../.gitbook/assets/screenshoteasy-2-.png) is changed to ![](../../.gitbook/assets/screenshoteasy-3-.png).
3. Then it is important to click on ![](../../.gitbook/assets/screenshoteasy-31-.png) button where it is showing ![](../../.gitbook/assets/screenshoteasy-3-.png).

{% hint style="info" %}
All the changes are made to the current table version.
{% endhint %}

{% hint style="info" %}
There are no limitations in creating Input/Output model. A model can have unlimited root objects and unlimited children.
{% endhint %}

### Creating a Model

The Model has the same structure as a tree and should be written in JSON format. There are root objects that contain children, but only leaf objects (objects without children) can be selected as variables.

#### There is only one option on how to create a leaf object:

* Object with empty **{}**: `"object": {}`

{% hint style="warning" %}
Arrays and values are not allowed.
{% endhint %}

#### Example of a simple model with leaves only:

```javascript
{
    "distance": {},
    "tariff": {},
    "weight": {},
    "longestSide": {}
}
```

#### Example of a complex model:

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

The button ![](../../.gitbook/assets/screenshoteasy-14-.png) will change your written code to a better readable format.

{% hint style="info" %}
This functionality is especially useful when **copying and pasting** JSON from another source or window on your device.
{% endhint %}

### Valid JSON format

If the text has a valid JSON format, ![](../../.gitbook/assets/screenshoteasy-17-.png) is shown, otherwise, ![](../../.gitbook/assets/screenshoteasy-18-.png) is shown. The text has to be modified to a valid format before saving.
