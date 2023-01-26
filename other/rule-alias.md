---
description: This page contains information about the rule alias feature.
---

# Rule Alias

## About the rule alias

Rule alias is a more comfortable and convenient alternative to rule ID. Unlike rule ID, the rule alias can be set by the user. Then it may be used to refer to the rule from other rules or when calling the Rule Solver API.

### Setting rule alias

Rule alias can be set via rule settings, this applies to all rule types.

{% hint style="info" %}
Rule alias can be any string containing letters, numbers and the - character.
{% endhint %}

Rules created in DecisionRules version 1.12 and smaller will have no rule alias but the user may provide one if they want. All newly created rules will have auto-generated rule aliases that can be freely edited.

<figure><img src="../.gitbook/assets/image (2) (2).png" alt=""><figcaption><p>setting up a custom rule alias</p></figcaption></figure>

{% hint style="warning" %}
Rule alias does not have to be strictly unique within the space. However, it is greatly recommended to keep your rule alias unique, since requests with non-unique alias will typically fail.
{% endhint %}

If you assign two identical rule aliases to several rules in a single space, the conflicting rule aliases are displayed in red color.

<figure><img src="../.gitbook/assets/image (6).png" alt=""><figcaption><p>rule alias conflict</p></figcaption></figure>

### Solving rules with rule alias

Solving rules with rule alias works the same way as with rule id (rule flow id). All you need to do is to replace the rule id (rule flow id) in the request with the respective rule alias.

<figure><img src="../.gitbook/assets/image (4).png" alt=""><figcaption><p>call on solver endpoint made with rule alias via postman</p></figcaption></figure>

Rule aliases can be used in the `SOLVE` function in decision tables and decision trees, as well as the `DR.solve` function available in scripting rules.

<figure><img src="../.gitbook/assets/image (2).png" alt=""><figcaption><p>solving rule with calling SOLVE() function via rule alias as parameter</p></figcaption></figure>

### Using rule alias with management API

There is a possibility to use rule aliases with Management API as well. Just replace the rule ID (rule flow ID) with the respective rule alias and all the requests to the Management API should work as before.
