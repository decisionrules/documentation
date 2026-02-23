# Execution Strategy

Execution strategy allows you to change the outcome produced by the rule solver. \
There are several options for the execution strategy described below.

## How to Set Execution Strategy

You can set the execution strategy in two ways:

* [**Solver API**](../../api/rule-solver-api.md) → by adding the appropriate HTTP header.
* [**Test Bench**](test-bench.md) → select the strategy from the dropdown.

<div><figure><img src="../../.gitbook/assets/Screenshot 2026-02-17 at 11.57.50.png" alt=""><figcaption><p>Options for Decision Table</p></figcaption></figure> <figure><img src="../../.gitbook/assets/Screenshot 2026-02-17 at 11.56.17.png" alt=""><figcaption><p>Options for Lookup Table</p></figcaption></figure></div>

## Allowed Strategies per Rule Type

| Rule Type                        | Allowed Strategies                         |
| -------------------------------- | ------------------------------------------ |
| Decision Table                   | Standard, Array, First Match, Evaluate All |
| Decision Tree                    | Standard, Array                            |
| Scripting Rule                   | Standard, Array                            |
| Rule Flow                        | Standard, Array                            |
| Decision Flow + Integration Flow | Standard                                   |
| Lookup Table                     | Lookup Exists, Lookup Value                |

## Setting Strategy via API

### Standard Rules Header

For all rule types except Lookup Tables, use the `X-Strategy` header to set the execution strategy:

| HTTP Header | Possible value |
| ----------- | -------------- |
| X-Strategy  | STANDARD       |
| X-Strategy  | ARRAY          |
| X-Strategy  | FIRST\_MATCH   |
| X-Strategy  | EVALUATE\_ALL  |

{% hint style="warning" %}
If the header is not specified or contains an invalid strategy, the system automatically uses the **STANDARD** strategy.
{% endhint %}

### Lookup Table Header

Lookup Tables use a dedicated header `X-Lookup-Method` instead of `X-Strategy` :

| HTTP Header     | Possible value |
| --------------- | -------------- |
| X-Lookup-Method | LOOKUP\_VALUE  |
| X-Lookup-Method | LOOKUP\_EXISTS |

{% hint style="warning" %}
If the header is not specified, the system automatically uses the **LOOKUP\_VALUE** strategy.
{% endhint %}

## Strategy Behavior

### Standard

Returns all matching rows in the same order as they appear in the rule.

If 2 rows are matching the input, the output will contain all matching rows:

```json
[
  {
    "client": { "segment": "affluent" },
    "profitability": 1
  },
  {
    "client": { "segment": "top affluent" },
    "profitability": 1.6
  }
]
```

#### **Useful for:**

* Getting all possible matches for a given input.
* Scenarios where multiple rules can apply simultaneously.

### First Match

Returns only the first matching row from the rule. Evaluation stops after the first match is found.

If 2 rows are matching the input, only the first match is returned:

```json
{
  "client": { "segment": "affluent" },
  "profitability": 1
}
```

#### **Useful for:**

* Priority-based rules where order matters.
* Decision scenarios where only one outcome should apply.

{% hint style="info" %}
Available for **Decision Tables only**.
{% endhint %}

### Array

Returns all matching outputs merged into a single object where each output field contains an array of all matched values.

If 2 rows are matching the input, the outputs are returned in array format:

```json
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
```

#### **Useful for:**

* Aggregating multiple matching results into a single response.
* Building lists of applicable values from multiple matches.

### Evaluate All

Returns a result for every row in the table regardless of whether it matched or not. Each result includes a `_match` field indicating whether that row was satisfied by the input.

```json
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

#### **Useful for:**

* Auditing and compliance - see which rules applied and which didn't.
* Debugging complex tables with many conditions.
* Satisfiability analysis across all rows - table has N rows, the response will contain N objects.

{% hint style="info" %}
Available for **Decision Tables only**.
{% endhint %}

### **Lookup Value**

Returns the value found in the Lookup Table that match the input. This is the standard way to retrieve data from a Lookup Table.

```json
{ "output": "value 1" }

// Can return entire row if no column is specified:
{
  "output": {
    "Primary Key": "inputKey",
    "column 1": "value 1",
    "column 2": "value 2"
  }
}
```

#### **Useful for:**

* Retrieving actual data stored in the Lookup Table.
* Any scenario where you need the actual stored value.

For detailed information with examples see Lookup [Value function](../lookup-table/using-lookup-tables-in-rules.md#lookup_value).

{% hint style="info" %}
Available for **Lookup Table only**.
{% endhint %}

### **Lookup Exists**

Returns a boolean indicating whether a matching record exists in the Lookup Table, without returning the actual value.

```json
{ "output": true }
```

#### **Useful for:**

* Validating if a value is in an allowed list.
* Checking membership (e.g., is this customer in the VIP list?).
* Input validation before processing.
* Blacklist/whitelist verification.

For detailed information with examples see [Lookup Exist function](../lookup-table/using-lookup-tables-in-rules.md#lookup_exists).

{% hint style="info" %}
Available for **Lookup Table only**.
{% endhint %}
