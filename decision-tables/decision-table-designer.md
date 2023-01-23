---
description: The heart of the Decision Table
---

# Table Designer

In this section, you can easily create your business rules, then link them to input and output data. Business rules are created to easily design or change the rules and deploy them quickly.

<figure><img src="../.gitbook/assets/image (242).png" alt=""><figcaption></figcaption></figure>

#### Applying changes

After each change, press the ![](../.gitbook/assets/save.PNG) button in the bottom right corner to save your progress.

{% hint style="info" %}
All the changes are made to the current table version.
{% endhint %}

## Conditions

Conditions are used to define input values.

### Adding Conditions

To add a new condition, click on the plus symbol in the header of a condition column.

<img src="../.gitbook/assets/image (74).png" alt="" data-size="original">

### Select value from Input Model

It is necessary to select some value from the Input Model.\
To do this, click on ![](<../.gitbook/assets/screenshoteasy (24).png>) button under the condition name. All possible values will be expanded, and then you can select one of them

{% hint style="info" %}
More information is in the [Binding To Model](binding-to-model.md).
{% endhint %}

### Delete Condition

To delete a condition from the Designer, click on the gear icon in the header of said condition, then click the remove button in the dropdown menu.

![](<../.gitbook/assets/image (226).png>)

## Results

Results are used to define output values.

### Adding Result

To add a new result column, click on the plus symbol in the header of another result column.

![](<../.gitbook/assets/image (105).png>)

### Select value from Output Model

It is necessary to select some value from the Output Model.\
To do this, click on![](<../.gitbook/assets/screenshoteasy (24).png>)button under the condition name. All possible values will be collapsed, and then you can select one of them.

{% hint style="info" %}
More information is in [Binding To Model](binding-to-model.md).
{% endhint %}

### Delete Result

To delete a result column from the Designer, click on the gear icon in the header of said result column, then click the remove button in the dropdown menu.

![](<../.gitbook/assets/image (250).png>)

## Row

A row represents one rule for specified data. If it's called, the [Rule Solver](../api/rule-solver-api.md) or the[Test Bench](broken-reference) with Input Data corresponding to **conditions** in a row, the[ Rule Solver](../api/rule-solver-api.md) or the [Test Bench](broken-reference) response will have the same data specified in **results** in the corresponding row.

### Adding Row

To add a new row, click on <img src="../.gitbook/assets/image (256).png" alt="" data-size="line"> button in the bottom panel.

### Fill Condition cell

For every condition cell, choose an **Operator** and write a **Value** (if necessary).\
Possible operators are specified in [Operators](operators/), and possible values for data types are specified in [Data Types](data-types.md).

### Fill Result cell

Possible results for data types are specified in[ Data Types](data-types.md).\
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

To use a row in the **Test Bench**:

* Click on the ![](<../.gitbook/assets/image (26) (1).png>) button

After using one of the options, the row is copied to the [Test Bench](broken-reference) at the bottom of the page.

### Change the order of Rows

To change the position of the row, click on![](<../.gitbook/assets/screenshoteasy (27).png>) the button. After that, select **Move.**

It will open new modal, where you can specify the new position of selected row.

![](<../.gitbook/assets/image (181) (1).png>)

### Time row validation

You can specify in which time period the row will be active and when it will not be active. To set the time validation, click on the <img src="../.gitbook/assets/image (180) (1).png" alt="" data-size="original"> button. You will then be presented with a new modal where you can select a time range **from** and **to**.&#x20;

![](<../.gitbook/assets/image (156) (1).png>)

**Date** and **GMT** must be set, **Time** is optional.

{% hint style="success" %}
By default all rows are not **time limited**, so they will **always be evaluated**. If time validation is set, the row will only **be evaluated in the set period.**
{% endhint %}

{% hint style="info" %}
The row with the setting shown **in the image above** is valid **from** 29 April 2022 00:00:00 GMT+2 **to** 30 April 2022 23:59:59 GMT+2
{% endhint %}

## Check Table for duplicates

To check the table for duplicate rows, click the ![](<../.gitbook/assets/screenshoteasy (27).png>) button in the bottom panel, then click the<img src="../.gitbook/assets/image (215).png" alt="" data-size="line"> button. Clicking this button compares the input values in the table. If it finds rows, which are the same it highlights them. It works only on the input model as the output model can be the same.

![](<../.gitbook/assets/image (125).png>)

## Debug

The debug button ![](../.gitbook/assets/debug.PNG) is on the test bench shown on the bottom of the table designer. By default debug mode is turned off, by clicking on it the user turns it on.

<figure><img src="../.gitbook/assets/image (218).png" alt=""><figcaption></figcaption></figure>

The debug mode is used for showing the rows in the table which meet the input. It highlights the row with green color.

![](<../.gitbook/assets/image (127) (1).png>)

{% hint style="info" %}
For a larger view of the test bench, you can use the maximize button in the right corner. Looks like this: ![](../.gitbook/assets/max.png)
{% endhint %}

## AutoSave button

The AutoSave button ![](<../.gitbook/assets/image (154) (1) (1).png>) is located on the bottom of the Decision Tables page, next to the button ![](<../.gitbook/assets/image (156) (1) (1).png>) / ![](<../.gitbook/assets/image (169) (1) (1) (1).png>).

### Highlight the active columns and rows

If you are getting lost between columns and rows, there is an option to highlight active rows and columns. This function is hidden under the button <img src="../.gitbook/assets/image (161) (1) (1) (1).png" alt="" data-size="original">in the navigation toolbar in the bottom of Decision Tables.

<figure><img src="../.gitbook/assets/image (236).png" alt=""><figcaption></figcaption></figure>

Choose what you want to get highlighted and activate the option. The row/ column will be highlighted with light green - as it is demonstrated in the picture below.

<figure><img src="../.gitbook/assets/image (217).png" alt=""><figcaption></figcaption></figure>

## Undo & Redo

There is a local history of every change in this designer.\
It is possible to undo or redo change by clicking on ![](<../.gitbook/assets/screenshoteasy (20).png>)or![](<../.gitbook/assets/screenshoteasy (21).png>)button.
