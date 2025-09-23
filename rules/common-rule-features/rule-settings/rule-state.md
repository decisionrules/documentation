# Rule State

## The two rule states

Every Rule (Decision Rule/Scripting Rules/Rule Flow) table has two control states: **`Published`** and **`Pending`**. The state can be set on every **version** of the rule separately.

Decision tables and scripting rules are in **`Published`** state when created, but Rule Flow are in **`Pending`** state as well as all newly created versions and all imported rules.

### Published state

Rule in **`Published`** state is ready for production and is available via [Solver API](../../../api/rule-solver-api.md).

#### Examples:

![](<../../../.gitbook/assets/image (15) (2).png>)

![](<../../../.gitbook/assets/image (10) (2).png>)

### Pending state

Some rules or versions of rules are not yet ready for production. For example, because the rule is still in development. Such a rule has a "Pending" status and it cannot be accessed using [Solver API](../../../api/rule-solver-api.md). When trying to solve such a rule, [Solver API](../../../api/rule-solver-api.md) returns the following HTTP request error:

```javascript
400 Bad Request
{
  "error": {
    "message": "Rule state is not published"
  }
}
```

{% hint style="success" %}
For the purpose of testing your rules and their versions that are not yet in production, you can use the **Debug** in [Test Bench](../test-bench.md) to solve the rule even if it is in the "Pending" state.
{% endhint %}

#### Example:

![Rule in pending state](<../../../.gitbook/assets/image (14) (2).png>)

### How to change the rule state

The state can be changed in rule detail by clicking on "State". The rule **must be saved** to apply the changes made on the state.

![](<../../../.gitbook/assets/image (11) (2).png>)
