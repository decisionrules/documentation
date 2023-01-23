---
description: '*Applies to all Rule types - Decision Rules, Scripting Rules and Rule Flows'
---

# Rule State

## The two rule states

Every Rule (Decision Rule/Scripting Rules/Rule Flow) table has two control states: **`Published`** and **`Pending`**. The state can be set on every **version** of the rule separately.

Decision tables and scripting rules are in **`Published`** state when created, but Rule Flow are in **`Pending`** state as well as all newly created versions and all imported rules.

### Published state

Rule in **`Published`** state is ready for production and is available via [Solver API](../api/rule-solver-api.md).

#### Examples:

![](<../.gitbook/assets/image (15) (1).png>)

![](<../.gitbook/assets/image (10) (1).png>)

### Pending state

{% hint style="info" %}
Rules in\*\*`Pending` \*\* state is not available via [Solver API](../api/rule-solver-api.md). If you try to call "pending" rule, [Solver API](../api/rule-solver-api.md) returns the following HTTP error:
{% endhint %}

```javascript
400 Bad Request
{
  "error": {
    "message": "Rule state is not published"
  }
}
```

#### Example:

![Rule in pending state](<../.gitbook/assets/image (14) (1).png>)

### How to change the rule state

The state can be changed in rule detail by clicking on "State". The rule **must be saved** to apply the changes made on the state.

![](<../.gitbook/assets/image (11).png>)
