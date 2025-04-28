# Warnings & Errors

## Warnings

If the rule is not mapped in the Rule Flow, it will be demarcated by a **yellow border** with an icon![](../../.gitbook/assets/warningError2.png). If you save a rule with warnings, the state automatically switches to **pending**.

![](../../.gitbook/assets/warningBox.PNG)

{% hint style="info" %}
When you point to the![](../../.gitbook/assets/warningError2.png), warning information will be displayed.
{% endhint %}

### Types of warnings:

* The rule is missing mapping.

To fix this, map the data in a rule. At least one output must always be mapped for the mapping to be valid and no warnings to be displayed.

{% hint style="warning" %}
Rule Flow with warnings is automatically set to pending and cannot be called via Rule Flow Solver API
{% endhint %}

## Errors

Errors are serious mistakes that prevent Rule Flow from being saved. A **red border** and an icon![](../../.gitbook/assets/errorIcon.png)appear next to a rule that contains errors.

![](../../.gitbook/assets/ErrorBox.PNG)

{% hint style="info" %}
When you point to the![](../../.gitbook/assets/errorIcon.png), errors information will be displayed.
{% endhint %}

### Types of errors:

* The rule is not connected with the input
* The rule is not connected with the output

To fix this connect all boxes to the Input box and Output box.

* The rule is not selected.

To fix this choose a rule into the empty box by clicking![](../../.gitbook/assets/selectRule.PNG)in the sidebar.

* Cannot find the rule.

The rule is probably deleted and can no longer be used in Rule Flow.
