# Managing Decision Table in Excel/Google Sheets

{% hint style="warning" %}
As of release **1.19.0**:&#x20;

The following description applies to the second version of XLSX export. Version 1, which can still be accessed via the **Deprecated → XLSX v.1** menu, is now outdated. While version 1 remains usable for imports, it lacks support for some of the newer features. **We highly recommend switching to version 2.**

For more information on deprecated formats, refer to the [dedicated section](manage-tables-excel-gsheets.md).
{% endhint %}

## Managing Decision Tables Outside the App

You can manage decision tables outside of the DecisionRules application for easier, faster, and clearer editing. We recommend using Microsoft Excel or Google Sheets, as they support the XLSX format.

{% hint style="danger" %}
Other formats like ODT or simple XLS are not compatible.
{% endhint %}

There are two ways to create decision tables in XLSX format:

1. Create an XLSX file from scratch, following the exact format outlined here.
2. Start with a basic table in DecisionRules, export it, and then edit it.

We recommend the second option for ease of use.

## File Structure of XLSX Format

Imported and exported files require both mandatory and optional structural elements. The file contains four sheets:

## Settings

### Mandatory Elements

* **Export Version**: Always set to **2**.
* **Name**: The name of the decision table.
* **Rule Alias**: An[ alias for the rule](../rule-alias.md); only English letters, numbers, and hyphens ("-") are allowed.
* **Version**: The [version number](../versioning.md) of the rule.
* **Status**: The decision table's [status](../rule-state.md), either **published** or **pending**.
* **Input Model:** Describes the [input variables](../input-and-output/) for the decision table, where each variable is defined as an object with attributes or substructures.
* **Output Model**: Describes the expected [output variables](../input-and-output/) for the decision table.

### Optional Elements

* **Rule ID**: The unique ID for the rule, automatically generated if not provided during import.
* **Created**: The creation date in ISO 8601 format, automatically generated if not provided.
* **Tags**: An array of [rule tags](../tagging.md), which can be an empty array or a list of strings if provided.
* **Note**: A description of the table.

### Settings Example:

![Settings in the xlsx file](<../../../.gitbook/assets/settingss xlsx.png>)

## Rule Variables

There are no mandatory elements in this section; you can define the [rule variables ](../rule-variables.md)here if needed. This section includes two columns: **variable name** and **value**, just as in the application.

<figure><img src="../../../.gitbook/assets/rule variables excel.png" alt=""><figcaption><p>Rule variables in the xlsx file</p></figcaption></figure>

<figure><img src="../../../.gitbook/assets/rule variables in the app.png" alt=""><figcaption><p>Rule variables in the app</p></figcaption></figure>

## Table

This sheet contains the decision table itself.

<figure><img src="../../../.gitbook/assets/table sheet.png" alt=""><figcaption><p>Table in the Table sheet of xlsx file</p></figcaption></figure>

<figure><img src="../../../.gitbook/assets/table export.png" alt=""><figcaption><p>The table in the DecisionRules app</p></figcaption></figure>

### Columns Settings

Each column requires three **mandatory** headers:

* **Column Alias**: [The unique identifier](../../decision-table/decision-table-designer/#set-column-alias) for the column, which can contain only English letters, numbers, and hyphens.
* **Column Type**: Must be set to **condition**, **calculation**, or **output**. For more information on column types and their order, refer to the [table designer](../../decision-table/decision-table-designer/#column-types-and-table-structure) section.
* **Column Title**: The name of the column.

Optional Element:&#x20;

* **Column Value**: This field, located under the column title, maps the column to a value such as input, output, or variables. While optional in the XLSX file, it is essential for table solving, and columns must be mapped once the table is imported.

<div align="center"><figure><img src="../../../.gitbook/assets/column in the xlsx (2).png" alt=""><figcaption><p>A column defined in xlsx</p></figcaption></figure> <figure><img src="../../../.gitbook/assets/column in the app.png" alt=""><figcaption><p>The same column in the app </p></figcaption></figure></div>

### Rows Settings

Each row includes several options:

* **Active**: Defines whether the row is [activated or deactivated](../../decision-table/decision-table-designer/#deactivate-and-activate-row). Accepts **Yes** or **No** values; if left empty, the default is **No**.
* &#x20;**Time Validation**: Specifies the time range during which the[ row is valid](../../decision-table/decision-table-designer/#time-row-validation). This accepts an object in the format `{"from":"YYYY-MM-DD HH:MM Z", "to":"YYYY-MM-DD HH:MM Z"}`, where **Z** represents the time zone in the `±HH:MM` format.&#x20;

{% hint style="danger" %}
Time zones must be specified for both **from** and **to**, even if only one limit is needed.
{% endhint %}

<div><figure><img src="../../../.gitbook/assets/active and time validation xlsx.png" alt=""><figcaption><p>Row settings xlsx</p></figcaption></figure> <figure><img src="../../../.gitbook/assets/active and time validation app.png" alt=""><figcaption><p>Row settings app</p></figcaption></figure></div>

### Table Content

Each row for each column contains two parts:

* **Operator**: The table [operator](../../data-types-and-functions/operators/). Available operators can be selected from a dropdown list. Calculation columns must use the **function** operator.
* **Value**: The cell value of the table. For restrictions on cell values, refer to the [Supported Data Types](../../data-types-and-functions/data-types.md) and [Operators sections](../../data-types-and-functions/operators/)

<div><figure><img src="../../../.gitbook/assets/operators and values xlsx.png" alt=""><figcaption><p>Operators and values condition columns xlsx</p></figcaption></figure> <figure><img src="../../../.gitbook/assets/operators and values table.png" alt=""><figcaption><p>Operators and values condition columns app</p></figcaption></figure></div>

## Valid Values

This sheet defines [valid values ](../../decision-table/decision-table-designer/table-operations/valid-values.md)for each column. It includes two headers:

* **Column Alias**: Maps the column to the valid value. The alias must match the alias used in the [Table sheet](managing-decision-table-in-excel-google-sheets.md#table). If the app cannot locate the column with this alias, those valid values will not be applied. This field is case-sensitive.
* **Column Name**: This optional field is for user convenience, so you don't have to memorize which alias corresponds to which column.

To add valid values for a column, enter the column alias and column name, then list the values one under the other:

<div><figure><img src="../../../.gitbook/assets/column alias (2).png" alt="" width="174"><figcaption><p>Column alias in the Table sheet</p></figcaption></figure> <figure><img src="../../../.gitbook/assets/valid value xlsx.png" alt="" width="223"><figcaption><p>Valid values for the column</p></figcaption></figure></div>

When you import the table into the app, [valid values](../../decision-table/decision-table-designer/table-operations/valid-values.md) will appear in the column settings, and cells containing invalid values will be flagged:

<figure><img src="../../../.gitbook/assets/valid value app.png" alt="" width="200"><figcaption><p>Invalid value</p></figcaption></figure>



## Final Notes

Managing Decision Tables in Excel or Google Sheets offers a structured approach with specific settings for version control, rule variables, columns, rows, and valid values. XLSX version 2, the recommended format, supports advanced features that are not available in version 1. Adhering to the correct structure ensures smooth imports, consistent decision-making rules, and easier integration of validation for input and output variables.
