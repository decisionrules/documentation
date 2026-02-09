# Rule Variables

Rule variables simplify editing when working with values that appear multiple times across your rules.

**Rule variables work identically across all rule types** - Decision Tables, Decision Trees, and Scripting Rules - though the syntax for using them varies by rule type.

{% hint style="info" %}
Rule variables are version-specific. Each version of a rule maintains its own set of variables.
{% endhint %}

{% hint style="info" %}
In this guideline on how to create rule variables, you need to have knowledge of [Decision Table](../decision-table/) and [Scripting Rule](../scripting-rule/)
{% endhint %}

## **Creating and Managing Rule Variables**

Rule Variables are managed in the **left panel** of the rule editor. Here you can add, edit, or delete variables.

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-09 at 11.53.59.png" alt=""><figcaption></figcaption></figure>

#### **To create a new variable:**

1. Enter a **Name** (must be unique per rule).
2. Set a **Value** (number, text, or boolean).
3. Click the **Save** button or click **Enter.**

{% hint style="success" %}
Create variable names **without spaces and special symbols**, even though they are technically allowed.
{% endhint %}

#### **To edit a variable:**

1. Click the **Edit** button next to the variable.
2. Modify the value.
3. Click the **Save** button or click **Enter.**

{% hint style="warning" %}
Save your changes – otherwise, the changed value of the rule variable will not be updated.
{% endhint %}

#### **To delete a variable:**

Click the **Delete** button next to the variable.

### Supported Value Types

Rule Variables support the following data types:

#### Simple Values

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-09 at 12.16.34.png" alt=""><figcaption></figcaption></figure>

```javascript
{ "output": [ 0.21, 18, 30, "EUR", "Prague", "Premium", true, false ] }
```

#### Arrays

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-09 at 12.21.08.png" alt=""><figcaption></figcaption></figure>

```javascript
[
    { "output": [15, 30, 45, 60] },                    // priceList
    { "output": ["Junior", "Standard", "Senior"] },    // categories
    { "output": [1, 2, true, "text"] }                 // mixedArray
]
```

#### JSON Objects

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-09 at 12.36.40.png" alt=""><figcaption></figcaption></figure>

```javascript
[
  { "output": { "id": 10, "name": "Peter", "occupation": "Developer" } },
  { "output": { "tax": 0.21, "currency": "EUR", "minAmount": 50 } }
]
```

{% hint style="warning" %}
While rule variables support complex objects and arrays, we **do not recommend using overly complicated rule variables**. Keep variables simple and focused.
{% endhint %}

### What Rule Variables CANNOT Do

Rule variables have important limitations that you should understand:

#### Reference other values

Rule variables are **static values only**. You cannot reference one variable from another or perform calculations between them.

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-09 at 12.47.24.png" alt=""><figcaption></figcaption></figure>

```javascript
[
  { "output": 30},
  { "output": "{price1} * 2" } // Returns literal string, NOT 60
]
```

While you might think `{input.field}` syntax would work based on other features, **rule variables do NOT support input placeholders**. The curly braces are treated as literal text.

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-09 at 12.44.19.png" alt=""><figcaption></figcaption></figure>

```javascript
[
    { "output": "[1, {input.value}, true, \"text\"]" },
    { "output": "{\"tax\":{income.tax},\"currency\":\"EUR\",\"minAmount\":50} }
]
```

#### Execute functions

Functions stored in rule variables are **NOT executed** - they are returned as strings.

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-09 at 12.48.38.png" alt=""><figcaption></figcaption></figure>

```javascript
[
  { "output": "BTW(10, {input}, 40)" },
  { "output": "GT(30, 50)" },
  { "output": "SUM(10, 20)" }
]
```

{% hint style="info" %}
If you need to use functions, write them directly in table.
{% endhint %}

## How to use Rule Variables

### **Rule Variables in Decision Tables**

There are several ways to use Rule Variables in Decision Table Designer:

#### **As the Column Condition**

In the column header, you can use the variable name directly.

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-09 at 14.17.12.png" alt=""><figcaption></figcaption></figure>

#### As the Comparison Value

In the condition cell, you will see reference with the `A` prefix

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-09 at 14.12.19.png" alt=""><figcaption></figcaption></figure>

**Both approaches achieve the same result** - comparing input data against your rule variable. Choose the style that makes your table more readable.

{% hint style="warning" %}
The column header is always the **left side** of the comparison. When you move a variable between the column header and the condition cell, you must **reverse the operator** to maintain the same logic.
{% endhint %}

#### As Part of the Function

Rule variables can be used inside functions and mathematical expressions, just like any other value (input fields, column values, or static numbers).

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-09 at 13.39.59.png" alt=""><figcaption></figcaption></figure>

This is useful when you want to calculate output without hardcoding them in each cell. If value change, you only update the variable once.

{% hint style="info" %}
Exactly the same use of Rule Variable applies to Decision Tree.
{% endhint %}

### **Rule Variables in Scripting Rule**

Usage of Rule Variables in Scripting Rules is super easy. All values are stored in the `ruleVariables` object that is exposed in the script. You can use these stored values everywhere in the script (as inputs for your function or as inputs for `DR.solve()` function).

You can access your Rule Variables with the dot notation same as with input and output. To get the value of a rule variable, you write `ruleVariables.<nameOfYourRuleVariable>`

```javascript
const foo = ruleVariables.foo;
const bar = ruleVariables.bar;

output.Output = `Values of Rule Variables are: ${foo} and ${bar}`;

return output;
```

{% hint style="danger" %}
You cannot set `ruleVariables` from script itself or overwrite existing Rule Variables.
{% endhint %}
