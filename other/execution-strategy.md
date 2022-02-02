# Execution strategy

Execution strategy allows you to choose from 3 options depending on the type of the desired result.

* **Standard** strategy (default)
* **Array** strategy
* **First Match** strategy
* **Evaluate All** strategy - Available only in decision tables

Execution strategy can be chosen in Test bench.

![](<../.gitbook/assets/image (157) (1).png>)

{% hint style="info" %}
**Rule Flow** always uses the first match strategy.
{% endhint %}

### Set Execution strategy for solver API

If X-Strategy header is not specified, system automatically chooses STANDARD strategy.

| HTTP Header | Possible value |
| ----------- | -------------- |
| X-Strategy  | STANDARD       |
| X-Strategy  | ARRAY          |
| X-Strategy  | FIRST\_MATCH   |
| X-Strategy  | EVALUATE\_ALL  |

## Examples

![](<../.gitbook/assets/image (140).png>)

### Standard - strategy

If 2 lines are matching the input, the output will be all the matching rows. The order will be the as the rows are defined in the rule.

**The output looks like this:**

```scheme
[
  {
    "client": {
      "segment": "affluent"
    },
    "profitability": 1
  },
  {
    "client": {
      "segment": "top affluent"
    },
    "profitability": 1.6
  }
]
```

### First match - strategy

If 2 lines are matching the input, the output is returning just the first matching line from the rule (table, script).

**The output looks like this:**

```scheme
[
  {
    "client": {
      "segment": "affluent"
    },
    "profitability": 1
  }
]
```

### Array - strategy

If 2 lines are matching the input, the outputs are returned in the array format.

**The output looks like this:**

```scheme
[
  {
    "client": {
      "segment": [
        "affluent",
        "top affluent"
      ]
    },
    "profitability": [
      1,
      1.6
    ]
  }
]
```

### Evaluate All - strategy

This execution strategy allows you to obtain satisfiability based on the input conditions of all rows in the decision table. If your decision table has N rows, the evaluation response will also be N objects. For each output, you will have an indication of whether the line was met or not.

**The output can looks like this:**

```scheme
[
  {
    "client": {
      "segment": "affluent"
    },
    "profitability": 1,
    "_match": true
  },
  {
    "client": {
      "segment": "top affluent"
    },
    "profitability": 1.6,
    "_match": false
  }
]
```
