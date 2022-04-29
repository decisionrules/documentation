# Table Designer

A table designer is the heart of decision tables. In this section, you can easily create your business rules, then link them to input and output data. Business rules are created to easily design or change the rules and deploy them quickly.

![](<../.gitbook/assets/image (124).png>)

#### Applying changes

For every changes applied, there is a need to save them.\
Then it is important to click on ![](../.gitbook/assets/save.PNG)button.

{% hint style="info" %}
All the changes are made to the current table version.
{% endhint %}

## Conditions

Conditions are used to define input values.

### Adding Conditions

To add a new condition, click on ![](<../.gitbook/assets/screenshoteasy (23).png>) button. After that, a new condition will be created.

### Select value from Input Model

It is necessary to select some value from the Input Model.\
To do this, click on ![](<../.gitbook/assets/screenshoteasy (24).png>) button under the condition name. All possible values will be expanded, and then you can select one of them

{% hint style="info" %}
More information is in the [Binding To Model](binding-to-model.md).
{% endhint %}

### Delete Condition

To delete the condition from the Designer, click on ![](<../.gitbook/assets/screenshoteasy (28).png>) button.

## Results

Results are used to define output values.

### Adding Result

To add a new result, click on ![](<../.gitbook/assets/screenshoteasy (25).png>) button. After that, a new result will be created.

### Select value from Output Model

It is necessary to select some value from the Output Model.\
To do this, click on![](<../.gitbook/assets/screenshoteasy (24).png>)button under the condition name. All possible values will be collapsed, and then you can select one of them.

{% hint style="info" %}
More information is in [Binding To Model](binding-to-model.md).
{% endhint %}

### Delete Result

To delete results from the Designer, click on![](<../.gitbook/assets/screenshoteasy (28).png>)button.

## Row

A row represents one rule for specified data. If it's called [Rule Solver](../api/rule-solver-api.md) or [Test Bench](../test-bench/test-bench.md) with Input Data corresponding to **conditions** in a row, the[ Rule Solver](../api/rule-solver-api.md) or [Test Bench](../test-bench/test-bench.md) response will have the same data specified in **results** in the corresponding row.

### Adding Row

To add a new row, click on ![](../.gitbook/assets/row.PNG) button. After that, a new row will be created.

### Fill Condition cell

For every condition cell, it is necessary to select **Operator** and **Value** if it is allowed.\
Possible operators are specified in [Operators](operators/), and possible values for data types are specified in [Data Types](data-types.md).

### Fill Result cell

A possible result for data types is specified in[ Data Types](data-types.md).\
To fill the result cell value, click on the existing value, then enter a new value.

### Copy Row

To copy a row, click on![](<../.gitbook/assets/screenshoteasy (27).png>)the button. After that, select one of the copy options, then the row will be copied. The copied row will have the same set of rules.

### Clear Row

To clear all sets of conditions and result values, click on![](<../.gitbook/assets/screenshoteasy (27).png>)the button. After that, select **Clear Row,** then all values in the row will be cleared.

### Inactive and Active Row

To Inactive the row, click on the ![](../.gitbook/assets/on.PNG) button. After that, the button changes to![](../.gitbook/assets/off-1.png.png). To reactive row click on the button again.

{% hint style="success" %}
By default all the rows in the tables are **ACTIVE.** This functionality can be used when you don't want to use the line in the rule for validation, but you might need to use it in the future.

If the row is **INACTIVE** it behaves in the same way, as it wouldn't be there.
{% endhint %}

### Delete Row

There are two options for deleting a row from the designer:

* Click on![](<../.gitbook/assets/screenshoteasy (28).png>)the button.
* Click on![](<../.gitbook/assets/screenshoteasy (27).png>)the button. After that, select **Delete Row**.

### Use Row in Test Bench

There are two options to use a row in **Test Bench**:

* Click on![](<../.gitbook/assets/screenshoteasy (29).png>) button
* Click on![](<../.gitbook/assets/screenshoteasy (27).png>) the button. After that, select **Use in Test Bench**.

After using one of the options, the row is copied to the [Test Bench](../test-bench/test-bench.md) at the bottom of the page.

### Change the order of Rows

To change the position of the row, click on![](<../.gitbook/assets/screenshoteasy (27).png>) the button. After that, select **Move.**

It will open new modal, where you can specify the new position of selected row.

![](<../.gitbook/assets/image (181).png>)

### Time row validation

You can specify in which time period the row will be active and when it will not be active. To set the time validation, click on the <img src="../.gitbook/assets/image (180).png" alt="" data-size="original"> button. You will then be presented with a new modal where you can select a time range **from** and **to**.&#x20;

![](<../.gitbook/assets/image (156).png>)

**Date** and **GMT** must be set, time is optional.

{% hint style="success" %}
By default all rows are not **time limited**, so they will **always be evaluated**. If time validation is set, the row will only **be evaluated in the set period.**
{% endhint %}

Other features which DecisionRules helps you to make your work more efficient and easier.

## Check Table

Check table is on the bottom of the page as a clickable button![](<../.gitbook/assets/check table.PNG>). By clicking on this button it compares the input values in the table. If it finds rows, which are the same it highlights them. It works only on the input model, the output model can be the same.

![](<../.gitbook/assets/image (125).png>)

## Debug

The debug button ![](../.gitbook/assets/debug.PNG) is on the test bench shown on the bottom of the table designer. By default debug mode is turned off, by clicking on it the user turns it on.

![](../.gitbook/assets/testBench.PNG)

The debug mode is used for showing the rows in the table which meet the input. It highlights the row with green color.

![](<../.gitbook/assets/image (127).png>)

{% hint style="info" %}
For a larger view of the test bench, you can use the maximize button in the right corner. Looks like this: ![](../.gitbook/assets/max.png)
{% endhint %}

## AutoSave button

The AutoSave button ![](<../.gitbook/assets/image (154) (1).png>) is located on the bottom of the Decision Tables page, next to the button ![](<../.gitbook/assets/image (156) (1).png>) / ![](<../.gitbook/assets/image (169) (1) (1).png>).

### Highlight the active columns and rows

If you are getting lost between columns and rows, there is an option to highlight active rows and columns. This function is hidden under the button ![](<../.gitbook/assets/image (161) (1) (1).png>)in the navigation toolbar in the bottom of Decision Tables.

![](../.gitbook/assets/gare.png)

Choose what you want to get highlighted and activate the option. The row/ column will be highlighted with light green - as it is demonstrated in the picture below.

![](<../.gitbook/assets/image (168).png>)

## Undo & Redo

There is a local history of every change in this designer.\
It is possible to undo or redo change by clicking on ![](<../.gitbook/assets/screenshoteasy (20).png>)or![](<../.gitbook/assets/screenshoteasy (21).png>)button.
