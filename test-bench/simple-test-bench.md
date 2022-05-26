---
description: >-
  In the past, DecisionRules used to have only a JSON test bench which made it
  harder for analysts and non-technical people to test given rules. That's why
  we have added a more user-friendly test bench.
---

# Simple Test Bench

### Used in Rule

![This test bench looks the same for all the rules.](../.gitbook/assets/simple-bench.png)

### Used in test bench component

![](../.gitbook/assets/inside-bench.png)

### Resizeable

Drag the purple line up to resize the test bench.

![](../.gitbook/assets/resize.png)

### Filling input

{% hint style="success" %}
If you want to use comma inside the input field, please put the whole word in double quote marks.

E.g. "some,text"
{% endhint %}

{% hint style="success" %}
The reason for having to put text with comma inside quote marks is that if you write 1,2,3 as input in the simple test bench, it will be interpreted as an array(list) on the backend.&#x20;

E.g. 1,2,3 would be converted to \[1,2,3]
{% endhint %}

### Date Input

You can input by clicking on the three dots <img src="../.gitbook/assets/image (157) (1).png" alt="" data-size="original">.

Then click on the date icon ![](<../.gitbook/assets/image (171) (1).png>).

Then a modal will popup .

![](<../.gitbook/assets/image (188) (1).png>)

Choose the date, time and time zone (only the time zone is required) and click save.

If you decide to change the date, you can simply click on the input that will change color on hover.

{% hint style="success" %}
To clear the input simply click on the mentioned three dots ![](<../.gitbook/assets/image (184) (1).png>) and then click on clear![](<../.gitbook/assets/image (179) (1).png>).
{% endhint %}

### Preset Values

In case that the rule used inside the simple test bench is a Decision Table, you can use preset values to fill out the input. The main aim is to minimize typing errors and speed up the process of testing a rule.

To use the preset values feature click on the three dots <img src="../.gitbook/assets/image (157) (1).png" alt="" data-size="original">.

Then click on the ![](<../.gitbook/assets/image (193).png>)option.

A popup modal will be presented to you with all the values that are used inside the column that corresponds to the input property.

![](<../.gitbook/assets/image (172).png>)

Now you can simply click on the value that you want to use inside the test bench.

{% hint style="success" %}
For large rules that have tens of possible values inside a given column, you can filter them out using the search bar.
{% endhint %}

### Switching between benches

Click on JSON Bench button to switch between the simple and JSON test bench.

![](../.gitbook/assets/switch.png)

{% hint style="success" %}
When you switch between the benches, the data will be persisted.
{% endhint %}

{% hint style="success" %}
One caveat being that if you input an array of objects inside the JSON bench, then switch to simple bench, it will show only the first object of that array.

Same applies for output.

However by switching back to the JSON bench, you will see that the array of data has been persisted and only the first object was changed (if you have made any changes inside the simple bench).
{% endhint %}

