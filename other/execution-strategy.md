# Execution strategy

Execution strategy allows you to choose from 3 options depending on the type of the desired result.&#x20;

* **Standard** strategy (default)
* **Array** strategy
* **First Match** strategy
* **Classify All** Strategy - Available only in decision tables

By clicking on Strategy in the test bench you can select the one that suits you.

![](<../.gitbook/assets/image (146).png>)

{% hint style="info" %}
**Rule Flow** always uses the first match strategy.
{% endhint %}

### Set Execution strategy for solver API

| HTTP Header | Possible value |
| ----------- | -------------- |
| X-Strategy  | STANDARD       |
| X-Strategy  | ARRAY          |
| X-Strategy  | FIRST\_MATCH   |
| X-Strategy  | CLASSIFY\_ALL  |

## Exampless

![](<../.gitbook/assets/image (140).png>)

### Standard - strategy

If 2 lines are matching the input, the output will be all the matching rows. The order will be the as the rows are defined in the rule.&#x20;

* The output looks like this:

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

* The output looks like this:

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

* The output looks like this:

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



### Classify All - strategy

This execution strategy allows you to obtain satisfiability based on the input conditions of all rows in the decision table. If your decision table has N rows, the evaluation response will also be N objects. For each output, you will have an indication of whether the line was met or not.

The output looks like this:

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
    "profitability": 1.6
  }
]
```
