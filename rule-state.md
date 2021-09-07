# Rule State

## Information

Every decision table has two control states: **`Published`** and **`Pending`**. The state can be set on every decision **table** and every **version**.

## Published state

Decision table in **`Published`** state is ready for production and is available via [Solver API](api/rule-solver-api.md).

#### Examples:

![](.gitbook/assets/image%20%2815%29.png)

![](.gitbook/assets/image%20%289%29.png)

## Pending state

{% hint style="info" %}
Decision tables in**`Pending`** state is not available via [Solver API](api/rule-solver-api.md). If you try to call "pending" decision table, [Solver API](api/rule-solver-api.md) returns the following HTTP error:
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

![Rule in pending state](.gitbook/assets/image%20%2813%29.png)

