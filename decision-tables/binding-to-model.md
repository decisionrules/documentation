---
description: Binding Input or Output model to Decision Table in decision table designer.
---

# Binding To Model

## Information

After creating the input and output model, it is necessary to set this model to the conditions and results in the decision table designer.

* Input model is bound to conditions.
* Output model is bound to results.

{% hint style="info" %}
Any leaf from the **input/output** model can be selected to set the **condition/result** variable. You cannot select a root that contains only one child as a **condition/result** variable.
{% endhint %}

#### Example of binding (Input Model):

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

When this Input Model is modeled, the following values can be selected as the condition value:

* delivery.distance.car
* delivery.distance.ship
* delivery.distance.plane
* delivery.tariff
* package.weight
* package.longestSide

## Binding Input model to Conditions

1. Go to **decision table detail**.
2. Go to section **Decision Table Designer**.
3. Create a new **condition**.
4. Select the **condition variable**.

{% hint style="info" %}
More information is in [Table Designer](decision-table-designer.md#select-value-from-input-model).
{% endhint %}

## Binding Output model to Result

1. Go to **decision table detail**.
2. Go to section **Decision Table Designer**.
3. Create a new **result**.
4. Select the **result variable**.                                                                                                                   &#x20;

{% hint style="info" %}
More information is in [Table Designer](decision-table-designer.md#select-value-from-output-model).
{% endhint %}

