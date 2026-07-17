---
description: Validate rules with saved Test cases and repeatable Test Suites.
---

# Rule Testing

Rule Testing lets you verify rule behavior against saved scenarios. Each scenario uses fixed input and expected output. You can rerun the same checks after any change.

This page provides a focused view of tests for an individual rule. To manage your tests from a global workspace view, navigate to the main Tests section.: [tests](../../../space/tests/ "mention")&#x20;

### Main benefits

* Validate rule changes before release.
* Catch unwanted side effects early.
* Recheck rules after a DecisionRules update.
* Understand rule behavior faster with real examples.

#### Rule Testing vs. Test Bench

* Test Bench: Used for ad-hoc checks while actively editing a rule.
* Rule Testing: Used for saved, repeatable validation.

### Core concepts

#### Test

The smallest testing unit. It stores:

* Name
* Rule reference (Alias and Version)
* Rule strategy
* Input data
* Expected output
* Ignored output properties (Optional: Used to exclude dynamic values like current dates or generated IDs from the validation).

#### Test Suite

A Test Suite is a collection of Tests. You can think of it as a folder for related scenarios.

A Test Suite is linked to a rule by:

* Rule alias
* Rule version

This makes the Test Suite specific to one rule version.

{% hint style="info" %}
In rare cases, a Test Suite can point to a rule that no longer exists. These Tests are marked as Orphaned Tests.
{% endhint %}

#### Test Runs

After execution starts, Test Run is created with state **Waiting**. During processing, it can also be **Running**.

Finished Test Runs can end as:

* **Passed**
* **Failed**
* **Error**
* **Canceled**

### What users can do

Rule Testing covers three main areas:

1. Rule-level Test management
2. Space-level Test management
3. Test Bench integration

### Rule-level Tests tab

Rule Testing adds a **Tests** tab next to **Model** and **Designer**.

<figure><img src="../../../.gitbook/assets/image (405).png" alt="Rule tabs"><figcaption><p>Rule tabs</p></figcaption></figure>

This tab is the main place to manage Tests for the opened rule. It shows all Test Suites and Tests linked to that rule.

#### Main actions

Users can:

* Create a new Test / Edit a Test
* Create a new Test Suite / Edit a Test Suite
* Filter by name
* Run all
* Run selected

If nothing is selected, the run action offers **Run all**. If the user selects one or more items, it also offers **Run selected**.

### **Test Detail Panel**

User can modify test in Test Detail window.

<figure><img src="../../../.gitbook/assets/Modify test.png" alt="Test detail"><figcaption><p>Test detail</p></figcaption></figure>

#### Run Test

Test Run is created for selected Test.

#### Load to Test Bench

Users can copy test input directly into [Test Bench](../test-bench.md). This makes failed tests easier to debug.



### Rule-level Test Runs overview

The left-side **Test Runs** panel focuses on execution results and debugging. Panel shows all Test Runs belongs to current rule. If user clicked on one Test Run, detail is shown.

<figure><img src="../../../.gitbook/assets/image (406).png" alt="Test Runs panel"><figcaption><p>Test Runs panel</p></figcaption></figure>

#### Test Run detail

Test Suites are collapsed by default. Users can expand a Test Suite to see its Tests.

<figure><img src="../../../.gitbook/assets/image (407).png" alt="Test Run detail"><figcaption><p>Test Run detail</p></figcaption></figure>

Users can expand a test to inspect:

* Input data
* Expected output
* Received output

Differences in received output are highlighted.

<figure><img src="../../../.gitbook/assets/image (408).png" alt="Output differencies"><figcaption><p>Output differences</p></figcaption></figure>

#### Available actions

From the left panel, users can:

* Open Test details
* Inspect Test in Test Bench

### Test Bench integration

Rule Testing integrates directly with Test Bench. Thera are few possibilities that can be shown.

<figure><img src="../../../.gitbook/assets/image (404).png" alt="Test Bench"><figcaption><p>Test Bench</p></figcaption></figure>

#### Save as test

After running a rule in Test Bench, users can choose **Save as Test**. This opens dialog with the current input and output already available. The user then fills in:

* target Test Suite
* name

#### Existing test match

If the current Test Bench input matches an existing test, the interface shows it. It also shows whether the current output matches the expected output. If multiple tests match the same input, infoo is shown

#### Updating expected output

If the input matches a saved test but the output differs, the user can update the test.This action ask for confirmation before replacing the expected output.

### Import and export

Tests and Test Suite can be exported as JSON. This export is separate from rule export.

{% hint style="info" %}
Exporting a rule does not include tests
{% endhint %}

Tests can also be imported to space, rule or Test Suite.

### Orphaned Tests

Orphaned Tests exist when the stored alias and version do not match any existing rule. Orphaned Tests can be shown in the space-level menu. Users can then move those tests to an existing rule.

### Rule Testing vs. Test Bench

[Test Bench](../test-bench.md) is best for ad-hoc checks while editing a rule. Rule Testing is best for saved and repeatable validation. Use Test Bench to explore. Use Rule Testing to verify.

### Automation

If you want to run tests programmatically, use the [Rule Testing API](../../../api/rule-testing-api.md).
