# Rule Flow Mapping

## What is the Rule Flow mapping?

To make the rule flow work, the rules must be mapped. By mapping, we decide which inputs should go to which outputs of the certain rules.

For an unmapped rule, a yellow border and a yellow exclamation mark appear in the right corner, as shown on the picture below:

![](<../.gitbook/assets/unmapped (1).PNG>)

In this case, the **rule** and the **output** box are not mapped.

#### Rule mapping

Open the mapping by clicking on![](../.gitbook/assets/dataMapping.PNG), the window will appear, where you can create the mapping.

![](../.gitbook/assets/mapping.PNG)

* In the **global variable**, select the rule you want to map, and in the output select the exact outputs you want to get mapped on the target input.

{% hint style="danger" %}
Please note that Decision Tables called from within Rule Flows are always called with the "First Match" strategy. Read more about strategies [here](../other/execution-strategy.md).

If you need the table to return an array of values you can call the table from a Scripting rule using the [DR.Solve()](../scripting-rules/call-embedded-rules-in-sr.md) method, and connect the Scripting Rule into the Rule Flow.
{% endhint %}

#### Example of correct mapping:

![](../.gitbook/assets/correctMapping.PNG)

{% hint style="success" %}
Notice that the mapped outputs are from various global variables, even from the input box itself. It means you can use any of the rules in the rule flow to be mapped not only the parent/child rules.
{% endhint %}
