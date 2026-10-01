# Test Bench

The Test Bench is a built-in testing environment that allows you to evaluate and validate your rules before deploying them to production. By entering input data and simulating rule execution, you can verify that your rules produce the expected outputs and identify any issues early in the development process.

{% hint style="info" %}
In this guideline you need to have knowledge of [Decision Table](../decision-table/) and [Decision Tree](../decision-tree/).
{% endhint %}

### **Why Use Test Bench**

* **Validate logic** - Ensure rules work correctly before deployment.
* **Test edge cases** - Verify behavior with different input scenarios.
* **Debug issues** - Identify and fix problems during development with [Debug Mode](test-bench.md#debug-mode).
* **View detailed execution** - See exactly which rows or branches executed.
* **Iterate quickly** - Make changes and test immediately.

## Accessing Test Bench

Test Bench is available for all rule types and provides a consistent testing experience across them.

**To open Test Bench:**

1. Navigate to any rule in the designer.&#x20;
2. Click to open the **Test Bench** in the bottom bar.

<figure><img src="../../.gitbook/assets/Frame 70 (2).png" alt=""><figcaption></figcaption></figure>

## Running a Rule

<figure><img src="../../.gitbook/assets/Frame 73.png" alt=""><figcaption></figcaption></figure>

The controls between Input and Output decide how the rule runs:

* **Run** – Evaluates the rule with the current input. The output appears on the right, with the execution time above it.
* **Strategy** – The execution strategy, shown below Run (for example _Standard_). Click it to change. See [Execution Strategy](execution-strategy.md).
* **Debug** – Shows how the input was evaluated.
* **Saving a Test** – Saves the current input and output as a test.
* **Run Options** – Additional settings at the bottom of the panel.

## Test Bench Modes

Test Bench offers two interface modes to accommodate different user preferences and use cases:

### **1. Simple Bench**

A simplified interface that displays input (left side of bench) and output (right side of bench) fields as individual form fields, making it easy to test rules without JSON knowledge.

**Best for:**

* Users unfamiliar with JSON.
* Quick testing with simple inputs.
* Clear visualization of individual fields.

<figure><img src="../../.gitbook/assets/Frame 71.png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Commas create arrays (e.g., `1,2,3` becomes `[1, 2, 3]`). To use a comma inside a value, wrap it in quotes: `"some,text"`.
{% endhint %}

#### Date Input **in Simple Bench**

Simple Bench provides a convenient date picker for date fields:

1. Click the **three dots** next to the field.
2. Click the **calendar icon**.

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-16 at 13.30.01.png" alt="" width="563"><figcaption></figcaption></figure>

3. Select:
   * **Date** (day, month, year)
   * **Time** (hours, minutes)
   * **Time zone**

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-16 at 13.30.59.png" alt="" width="375"><figcaption></figcaption></figure>

4. Click **Save**.

### 2. JSON Bench

A JSON editor interface for entering input and viewing output in standard JSON format.

**Best for:**

* Technical users comfortable with JSON.
* Complex nested data structures.
* Arrays of objects.
* Copy/paste from API responses.
* Precise control over data structure.

<figure><img src="../../.gitbook/assets/Frame 72.png" alt=""><figcaption></figcaption></figure>

### **Switching Between Modes**

**Data Persistence:**

* Input data is preserved when switching between Simple and JSON Bench.
* You won't lose your test data when changing views.

#### **Understanding Display Limitations in Simple Bench**

While Simple Bench is convenient for basic testing, it has limitations when handling complex nested structures. Here are important behaviors to be aware of:

**1. Objects Without Defined Children**

If your input model defines a parent object without specifying its children structure (as an empty object `{}`), and you provide actual nested data in JSON Bench, Simple Bench will display this as `[object Object]`.

```json
// Input Model

{
  "action": {
    "transaction": {}  // Empty object - no children defined
  }
}
```

```json
// Actual JSON Input

{
  "action": {
    "transaction": { // last children based on input model
      "transactionValue": 10000,
      "transactionCurrency": "USD",
      "transactionValueEurEquivalent": 9500
    }
  }
}

// Simple Bench Display:
action.transaction: [object Object]
```

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-16 at 13.59.16.png" alt=""><figcaption></figcaption></figure>

**What this means:**

* The model doesn't define what children `transaction` should have.
* Simple Bench can't break it down into individual fields.
* Display shows `[object Object]` as a placeholder.

**It still works:**

* The rule receives and processes the complete nested data correctly.
* This is only a display limitation in Simple Bench.
* Use JSON Bench to see and edit the full structure.<br>

2. **Arrays of Objects**

Arrays of objects behave differently depending on whether they're in input or output fields.

* **Input Fields:**\
  Not Practical in Simple Bench. Arrays of objects in input fields display as `[object Object], [object Object], [object Object]...`, which doesn't allow you to see or edit the actual data.

```json
// Input Model

{
  "factorList": {} // Empty object - no children defined
}
```

```json
// Actual JSON Input
{
  "factorList": [
    { "destinationRisk": 0, "historyRisk": 0 },
    { "destinationRisk": 1000, "historyRisk": 1000 }
  ]
}

// Simple Bench Display:
factorList: [object Object], [object Object]
```

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-16 at 14.00.43.png" alt=""><figcaption></figcaption></figure>

{% hint style="success" %}
Use **JSON Bench** for inputs containing arrays of objects.
{% endhint %}

* **Output Fields:**\
  Arrays of objects in output fields show a **View** button that opens a detail modal.

```json
// Output Model

{
  "factorList": {} // Empty object - no children defined
}
```

```json
// Actual JSON Output
{
  "factorList": [
    { "destinationRisk": 0, "historyRisk": 0 },
    { "destinationRisk": 1000, "historyRisk": 1000 }
  ]
}

// Simple Bench Display:
factorList: View
```

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-16 at 14.08.27.png" alt=""><figcaption></figcaption></figure>

**Viewing Details:**

1. Click the **View** button
2. A **Detail View** modal opens
3. See the complete structure:
   * Each array element numbered (0, 1, 2...)
   * All properties displayed with formatting
   * Collapsible structure for navigation

<figure><img src="../../.gitbook/assets/Screenshot 2026-02-16 at 14.09.14.png" alt="" width="563"><figcaption></figcaption></figure>

## Execution Modes

Test Bench supports different execution modes depending on the rule type and your testing needs. For detailed information about execution strategies and modes, see [Execution Strategy](execution-strategy.md).

## Debug Mode

Debug Mode provides detailed execution information, helping you understand exactly how your rule processes data and where issues might occur.&#x20;

Debug Mode is available for **Decision Tables** and **Decision Trees** only.

### How to Enable Debug Mode

1. Open Test Bench.
2. Look for the **Debug** toggle/checkbox.
3. Enable it (toggle to ON/checked state).
4. Click **Run** to execute with debug information.

<figure><img src="../../.gitbook/assets/Frame 74.png" alt=""><figcaption></figcaption></figure>

### Debug Decision Table

When Debug Mode is enabled for Decision Table, you get detailed visual feedback showing exactly how your input data matches against each condition.

#### **Visual Indicators**

**Row Highlighting:**

* The executed row(s) are visually highlighted in the table.

Shows which rows matched your input conditions.

**Cell-Level Feedback:**

* **Green cells** - Condition **passed** (evaluated to true).
* **Red cells** - Condition **failed** (evaluated to false).

This allows you to see exactly which condition caused a row to pass or fail.

**Value Display:**

* Each condition cell shows the **actual value** being compared.

You can see what the rule is evaluating against your input.

<figure><img src="../../.gitbook/assets/Screenshot 2026-09-24 at 9.06.26.png" alt=""><figcaption></figcaption></figure>

### Debug Decision Tree

When Debug Mode is enabled for Decision Trees, you can trace the execution path through the tree structure and see exactly which conditions were evaluated and which branch was taken.

#### **Visual Indicators**

**Block Highlighting:**

* **Colored borders** show which nodes were evaluated during execution.
* **Green-highlighted blocks** indicate the path that was taken and executed.
* **Red-highlighted blocks** indicate the path that was not taken.

Shows the decision flow from top to bottom through your tree.

**Value Display:**

* Condition blocks show the actual values being compared.

<figure><img src="../../.gitbook/assets/Screenshot 2026-09-24 at 9.07.37.png" alt=""><figcaption></figcaption></figure>

## Saving a Test

<figure><img src="../../.gitbook/assets/Frame 76.png" alt=""><figcaption></figcaption></figure>

Once a rule returns the output you expect, save it as a test so you can rerun the same check after every change.

1. Enter the input and click **Run**.
2. Next to **Test**, click **Save as Test**.
3. Choose the Test Suite and enter a test name. If the rule has no Test Suite yet, enter a name for a new one and it is created together with the test.
4. Click **Save**.

The test stores the current input, the output as the expected output, and the execution strategy. You can view and edit it in the rule's **Tests** tab.

**When the input matches a saved test**

If the input in Test Bench matches a test you already saved, **Save as Test** is replaced by the test's result:

* **PASSED** – The output matches the test's expected output.
* **FAILED** – The output differs. You can update the test to accept the new output.

Click the arrow icon next to the result to open that test in the **Tests** tab.

{% hint style="info" %}
A test does not store a solver version. The same test can be run on any version the space offers. You choose the version when you run it.
{% endhint %}

## Run Options

**Run Options** at the bottom of the Test Bench panel holds additional settings for the run. It is collapsed by default. Click it to expand.

<figure><img src="../../.gitbook/assets/Screenshot 2026-09-24 at 9.02.15 1.png" alt=""><figcaption></figcaption></figure>

#### **Solver Version**

Choose which solver version runs the rule. The versions offered are the ones enabled in the [space's Run Solver versions settings](../../space/settings.md#available-run-solver-versions-in-the-app).

If the space has only one version, there is nothing to choose, and every run uses that version.

{% hint style="info" %}
**The choice applies only to runs in Test Bench.** It does not change the space settings or the version your API calls use.
{% endhint %}

**Rule Flows** and **AI Agents** always run on V1, whichever version you choose. See [Exceptions](../../api/rule-solver-api/rule-solver-api.md#exceptions).
