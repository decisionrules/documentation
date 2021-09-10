# Warnings & Errors

## Warnings

If the rule is not mapped in the Rule Flow, it will be demarcated by a **yellow border** with an icon![](../.gitbook/assets/warningerror2.png). If you save a rule with warnings, the state automatically switches to **pending**.

![](../.gitbook/assets/warningbox.png)



{% hint style="info" %}
When you point to the![](../.gitbook/assets/warningerror2.png), warning information will be displayed.
{% endhint %}

### Types of warnings:

* The rule is missing mapping.

To fix this, map the data in a rule. At least one output must always be mapped for the mapping to be valid and no warnings to be displayed.

{% hint style="warning" %}
Rule Flow with warnings is automatically set to pending and cannot be called via Rule Flow Solver API
{% endhint %}

## Errors

Errors are serious mistakes that prevent Rule Flow from being saved. A **red border** and an icon![](../.gitbook/assets/erroricon.png)appear next to a rule that contains errors.

![](../.gitbook/assets/errorbox.png)

{% hint style="info" %}
When you point to the![](../.gitbook/assets/erroricon.png), errors information will be displayed.
{% endhint %}

### Types of errors:

* The rule is not connected with the input
* The rule is not connected with the output

To fix this connect all boxes to the Input box and Output box.

* The rule is not selected.

To fix this choose a rule into the empty box by clicking![](../.gitbook/assets/selectrule.png)in the sidebar.

* Cannot find the rule.

The rule is probably deleted and can no longer be used in Rule Flow.

## Others

To make it easier to work with rules in Rule Flow, the rules have the next 2 colors of borders.

![](../.gitbook/assets/colors.png)

## Purple - Neutral state

The purple border has a rule if it is in a neutral state - it has no warnings or errors.

![](https://gblobscdn.gitbook.com/assets%2F-MN4F4-qybg8XDATvios%2F-Mj33eM-1pe2YxkB1VhB%2F-Mj3GZ07xudX4JaU-akL%2FPurpleBox.PNG?alt=media&token=dee2f5d8-009a-4b5a-ba23-fe85be22793a)

## Green - Active state

If the user works with the rule, ie has it clicked and sees its sidebar, the rule changes color to green.

![](https://gblobscdn.gitbook.com/assets%2F-MN4F4-qybg8XDATvios%2F-Mj33eM-1pe2YxkB1VhB%2F-Mj3Gs65qt_xB_Z89q7j%2FGreenBox.PNG?alt=media&token=ec40fb96-61f1-4760-aeb8-b3248174023f)



