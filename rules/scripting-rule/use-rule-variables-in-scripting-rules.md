---
description: >-
  This page contains an simple tutorial how to implement Rule Variables into
  your Scripting rule script.
---

# Use Rule Variables in Scripting Rules

## Define Rule Variable

Rule Variables can be defined in Rule Settings section in scripting rule editor. All you need to do is to just simply define name and value of scripting variable.

![Rule Variables editor](<../../.gitbook/assets/image (168).png>)

More detailed overview what you can do with Rule Variables is described [here](../common-rule-features/rule-variables.md).

## Use Rule Variables in Scripting Rules

Usage of Rule Variables in Scripting Rules is super easy. All RVs values are stored in the`ruleVariables` object that is exposed in the script. You can use these stored values everywhere in the script (as inputs for your function or as inputs for `DR.solve()` function...)

{% hint style="danger" %}
Rule Variables supports JavaScript primitive data types only. (number, string, boolean, symbol)
{% endhint %}

```javascript
const foo = ruleVariables.foo;
const bar = ruleVariables.bar;

output.Output = `Values of Rule Variables are: ${foo} and ${bar}`;

return output;
```

## What you cant do

You cannot set `ruleVariables` from script itself or overwrite existing Rule Variable.
