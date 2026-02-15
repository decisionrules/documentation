# Test Bench

The Test Bench allows you to evaluate the rules created in the rule designer. By entering input data and clicking the **Run** button, you can simulate rule execution and view the results in real time. Test Bench helps ensure that the rules are functioning as intended before applying them in a live environment.

Test Bench works consistently across all rule types, ensuring a uniform testing experience. It comes in two variants. A user-friendly variant and the more technical JSON Bench. See the Decision Table Test Bench bellow as an example.

### Used in Rule

To access the Test Bench, click the <img src="../../.gitbook/assets/image (234).png" alt="" data-size="line"> button in the bottom bar.

<figure><img src="../../.gitbook/assets/table_test_bench_btn.png" alt=""><figcaption><p>Test Bench in bottom bar</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/table_test_bench_open.png" alt=""><figcaption><p>Open Test Bench</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/table_json_bench_open.png" alt=""><figcaption><p>JSON Bench</p></figcaption></figure>

### Test Bench resizing

Drag the purple line up to resize the test bench.

![Resizing of the Test Bench](../../.gitbook/assets/test_bench_resize.png)

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

You can input by clicking on the three dots <img src="../../.gitbook/assets/image (157) (1).png" alt="" data-size="original">.

Then click on the date icon <img src="../../.gitbook/assets/image (171) (1).png" alt="" data-size="original">.

A pop-up will be shown.

![](<../../.gitbook/assets/image (188) (1).png>)

Choose the date, time and time zone (only the time zone is required) and click save.

If you decide to change the date, you can simply click on the input that will change color on hover.

{% hint style="info" %}
To clear the input simply click on the mentioned three dots ![](<../../.gitbook/assets/image (184) (1).png>) and then click on clear![](<../../.gitbook/assets/image (179) (1).png>).
{% endhint %}

### Switching between benches

Click on JSON Bench button to switch between the simple and JSON test bench.

![](../../.gitbook/assets/switch.png)

{% hint style="success" %}
When you switch between the benches, the data will be persisted.
{% endhint %}

{% hint style="success" %}
One caveat being that if you input an array of objects inside the JSON bench, then switch to simple bench, it will show only the first object of that array.

Same applies for output.

However by switching back to the JSON bench, you will see that the array of data has been persisted and only the first object was changed (if you have made any changes inside the simple bench).
{% endhint %}

