---
description: >-
  Table comparison view can be a bit intimidating at first. In this article, we
  will do our best to clearly explain how to read it and use it most
  effectively.
---

# Decision Table Comparison

## Introduction

Imagine you have a production Decision Table and you want to make major changes to the logic behind it. Usually you would create a new version of said table and start changing it to fit your current needs. Once the table is done you test it and start using it in production.&#x20;

Now if the changes you made were really minor, you could probably remember what you changed. But for cases when you'd been working on version 2 for weeks you might forget what exactly has changed inside of each row or column. Enter Table Comparison.

{% hint style="info" %}
Decision Table Comparison is most useful when used between two roughly similar rules.

When used on two completely different rules the result won't usually be very helpful.
{% endhint %}

### Common Use-Cases

* You want to review your changes before implementing a new rule version into production.
* You wish to simply and quickly [add a column](decision-table-comparison.md#adding-removed-cols-or-rows) from a different rule to the one in question.&#x20;
* Visualization of progress between versions of production rules.

## The Comparison view

Upon opening the comparison view, you should see a table very similar to the table you've originally opened the comparison on (i.e. the green table). The Reference table has been superimposed onto the Original table and discrepancies between the tables are shown by use of The Color System.&#x20;

{% hint style="warning" %}
Be aware that you still essentially only have the Original (Green) rule opened. Any changes you make to cells, rows or columns will affect only the Original rule.
{% endhint %}

### The Color System

In comparison view, each table is given a color. <mark style="background-color:green;">**Green**</mark> for the Original table (the currently open table) and <mark style="background-color:blue;">**Blue**</mark> for the Reference table (the table we are comparing to).&#x20;

* Rows and/or columns shown in **White** appear in both Tables.&#x20;
* If a row or column is colored in <mark style="background-color:green;">**Green**</mark> as well as displaying a circular <mark style="background-color:green;">**Green**</mark> badge, this means the row/column in question appears **ONLY** in the Green (Original) table.
* If a row or column is colored in <mark style="background-color:blue;">**Blue**</mark> as well as displaying a circular <mark style="background-color:blue;">**Blue**</mark> badge, this means the row/column in question appears **ONLY** in the Blue (Reference) table
* Changes are shown differently between rows and columns
  * If a **row** displays a circular <mark style="background-color:yellow;">**Yellow**</mark> badge at least one of it's cell will be highlighted in <mark style="background-color:yellow;">**Yellow**</mark>. This means the row appears in **BOTH** tables but the highlighted cell's value has changed.
  * If a **column** displays a circular <mark style="background-color:yellow;">**Yellow**</mark> the column appears in **BOTH** tables but some of the column's features have changed. The column might now bare a different name, might have a different Input/Output Variable and/or might have a different Valid Values selection.

<figure><img src="../../../.gitbook/assets/image (273).png" alt=""><figcaption><p>Rows 9&#x26;10 on Australian birds has been added in v2. On the other had, column labelled '<strong>Ranking</strong>' has been removed from v2 when compared to v1. The selection of birds of Asia is now missing the "Golden Pheasant" entry.  </p></figcaption></figure>

### Interactivity

Table comparison doesn't only offer great informative value, it also makes manipulation with rows and columns easier.

#### Adding removed cols or rows

Any <mark style="background-color:blue;">Blue</mark> row or column can easily be added into the Original table by clicking the <mark style="background-color:blue;">Blue</mark> circular badge next to the row's number or inside the column's header.&#x20;

#### Merging rows

By clicking the <mark style="background-color:yellow;">Yellow</mark> circular badge next to a changed rows number you can show the row's state as it appears in the Reference table. If you prefer the row's state from the Reference rule, click the arrow ![](<../../../.gitbook/assets/image (266) (1).png>) to 'Merge' these two rows - changing the row's cells to those of the Reference table

You can always revert these changes by clicking the turquoise badge and then the undo arrow ![](<../../../.gitbook/assets/image (265) (1).png>).

<figure><img src="../../../.gitbook/assets/image (263) (1).png" alt=""><figcaption></figcaption></figure>

#### Real-time editing

Since the comparison view is just a different rendering of the currently open rule you can still edit the table as you would outside of the comparison view. Changing cells' values, adding and removing rows and columns etc. is still all available and the comparison should change accordingly.

{% hint style="warning" %}
This might sometimes lead to unintuitive behavior as with most changes the comparison will be re-evaluated and the result might suddenly seem different after making a seemingly insignificant change.
{% endhint %}

#### Navigation over row differences

To make navigation over compared rules easier, you can click the arrows on the comparison bar at the top to navigate to the next and previous found row differences.

### Comparison Statistics

To quickly see how and how much the compared rules differ, you can click the chart icon in the top left to display a dropdown summarizing the amount of differences between the tables, categorized over rows and columns.
