---
description: Decision tables management in XLSX files.
---

# Manage Decision Tables in Excel / Google Sheets

## How to manage Decision Tables outside the app

There is a way to manage your decision tables outside DecisionRules application. The reason for editing in Excel or Google Sheets is to make it easier, faster and clearer.

{% hint style="info" %}
We recommend you to use Microsoft Excel or Google Sheets, which can work with **XLSX** format, other format such as ODT or simple XLS are not compatible.
{% endhint %}

There are two options to make your decision tables in XLSX format:

1. You can create your own XLSX file from scratch, which has to be in the exact format [**shown here.**](import-and-export-rule/#file-structure-of-xlsx-format)\*\*\*\*
2. Set the basic table in DecisionRules as we have in the [guide ](../tutorials/create-simple-decison-table.md)and [export](import-and-export-rule/export-decision-table-xlsx.md) the table to start to edit.

{% hint style="success" %}
We recommend you the second option.
{% endhint %}

#### Exported table view

In our case, we are using the basic sample rule, which is available in DecisionRules.

![](<../.gitbook/assets/image (109).png>)

The table above shows how does the rule look like right after the export.

Now we will break down the table into smaller pieces with an explanation.

### Header

The header consists of 4 basic elements:

![](<../.gitbook/assets/image (112).png>)

* **Name:** the name of the table
  * text format
  * can be changed
  * import as a new table - this name is set
  * import to existing table - name from XLSX file is not changing the name
* **Description:** text, you can write here anything that appears in the table settings
* **Type:** the only supported type is **decision-table**
* **Status:** [more information](broken-reference/)
  * you have to choose - pending/published

### Hints

Link to documentation and quick hints for value formats.

![](<../.gitbook/assets/image (113).png>)

### Table

![](<../.gitbook/assets/image (114).png>)

The table consists of two basic parts:

* CONDITION - input (yellow)
* RESULT - output (red)

Every condition and result is a column in a table with its properties such as input/output model, column, operator and value.

### **CONDITION**

We will describe what does each line in the table means in the following example.

![](<../.gitbook/assets/image (118).png>)

Every condition is made of 2 columns.

* **Condition -** it has to be over both columns, it indicates the input (always the same)
* **Product Count -** the name of the column in the decision table
* **productCount -** input model attribute
  * **depositSum.usd** - input model attribute with embedded attribute
* **Operator** - dropdown to choose from the operator list (the header is always the same)
* **Value** - the values by themselves (the header is always the same)

### **RESULT**

![](<../.gitbook/assets/image (119).png>)

* **Result -** it indicates the output (always the same)
* **Client Segment -** the name of the column in the decision table
* **client.segment -** output model attribute with embedded attribute
  * **profitability** - output model attribute
* **Value** - the values by themselves (the header is always the same)

### Final notes

{% hint style="success" %}
In MS Excel or Google Sheets, you can add rows, columns, attributes, values and choose operators. The changes will be imported to Table Editor.
{% endhint %}

All the changes made in MS Excel or Google Sheets will be validated upon the import back to DecisionRules, in case of nonconformity the tool will notify the user to make sure all the details are correct and they can be imported.

{% hint style="info" %}
To add rows or columns the easiest way is to duplicate them from the table, then to change the properties.
{% endhint %}
