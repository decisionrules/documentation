# Rule Status

## The two rule statuses

Every Rule has two status options: `Published` and `Pending`. The status can be set on each version of the rule independently.

**Initial Status:**

* **Newly created rules:** All rules are created in `Published` status by default
* **Imported rules:** The status is determined by the value defined in the imported rule data
* **New versions:** All newly created versions start in `Pending` status

### Published status

Rule in Published status is ready for production and is available via [Solver API](../../../api/rule-solver-api.md).

#### Examples:

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-04 at 13.45.41.png" alt=""><figcaption><p>rules in Published status</p></figcaption></figure>

### Pending status

Some rules or versions of rules are not yet ready for production. For example, because the rule is still in development. Such a rule has a Pending status and it cannot be accessed using [Solver API](../../../api/rule-solver-api.md). When trying to solve such a rule, [Solver API](../../../api/rule-solver-api.md) returns the following HTTP request error:

```javascript
400 Bad Request
{
  "error": {
    "message": "Rule state is not published"
  }
}
```

{% hint style="success" %}
For the purpose of testing your rules and their versions that are not yet in production, you can execute rules in Pending status using two methods:

1. Use the **Debug** in [Test Bench](../test-bench.md) feature to solve the rule directly within the platform.
2. Include the **X-Debug: true** header when calling the rule via API.
{% endhint %}

#### Example:

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-04 at 13.50.22.png" alt=""><figcaption><p>rules in Pending status</p></figcaption></figure>

### How to change the rule status

The status can be changed in rule settings by clicking the **Status toggle**. The rule **must be saved** to apply the status change.

<div><figure><img src="../../../.gitbook/assets/Screenshot 2026-02-04 at 13.26.20.png" alt="" width="303"><figcaption><p>switched to Pending</p></figcaption></figure> <figure><img src="../../../.gitbook/assets/Screenshot 2026-02-04 at 13.39.58.png" alt="" width="303"><figcaption><p>switched to Published</p></figcaption></figure></div>
