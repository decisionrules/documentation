---
description: >-
  The Test Bench comes in two variants. A user-friendly variant and the more
  technical JSON Bench.
---

# Test Bench

### Used in Rule

To access the Test Bench, click the <img src="../.gitbook/assets/image (234).png" alt="" data-size="line"> button in the bottom bar.

<figure><img src="../.gitbook/assets/image (235).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/image (127).png" alt=""><figcaption><p>Rendered Test Bench</p></figcaption></figure>

<figure><img src="../.gitbook/assets/image (238).png" alt=""><figcaption><p>JSON Bench</p></figcaption></figure>

### Resizeable

Drag the purple line up to resize the test bench.

![](../.gitbook/assets/resize.png)

### Filling input

{% hint style="success" %}
If you want to use comma inside the input field, please put the whole word in double quote marks.

E.g. "some,text"
{% endhint %}

{% hint style="info" %}
The reason for having to put text with comma inside quote marks is that if you write 1,2,3 as input in the simple test bench, it will be interpreted as an array(list) on the backend.&#x20;

E.g. 1,2,3 would be converted to \[1,2,3]
{% endhint %}

### Date Input

You can input by clicking on the three dots <img src="../.gitbook/assets/image (157) (1).png" alt="" data-size="original">.

Then click on the date icon <img src="../.gitbook/assets/image (171) (1).png" alt="" data-size="original">.

A pop-up will be shown.

![](<../.gitbook/assets/image (188) (1) (2).png>)

Choose the date, time and time zone (only the time zone is required) and click save.

If you decide to change the date, you can simply click on the input that will change color on hover.

{% hint style="info" %}
To clear the input simply click on the mentioned three dots ![](<../.gitbook/assets/image (184) (1).png>) and then click on clear![](<../.gitbook/assets/image (179) (1).png>).
{% endhint %}

{% hint style="info" %}
If you're using the [Valid Values](../decision-tables/table-operations/valid-values.md) functionality in your Decision Table, it is also available in the Test Bench
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

