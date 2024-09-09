---
description: >-
  The version 1.19.0 of DecisionRules brings ground-breaking new features and
  improvements. This page features a summary of the main changes, which may be
  of importance mainly to current users.
---

# Changes in Version 1.19.0 (10/2024)

{% hint style="info" %}
Release 1.19.0 is currently under preparation. Consider the info on this page preliminary.
{% endhint %}

## Decision Table

Most of the changes of the already existing features are related to decision tables. We reworked the design, improved user experience and added new functionalities. All the important changes are reviewed in detail below.

### Table Redesign

There some changes made to decision tables visible at first sight. These are mostly aesthetic, and do not have impact on functionality. However, it may take a few moments for the user to find their way around and get used to the new look.

There are some changes in how the structure and design of column headers. The row headers have also been slightly changed as well. We adjusted the style of operators, made the height of the rows slightly smaller and introduced a more consistent color coding.

The decision table cell was redesigned to allow for easier and smoother editing experience. Switching between view and edit mode does not impact the layout of the table. The cell also does not have to be saved anymore, as it is autosaved upon editing.

{% hint style="info" %}
We have invested great effort to ensure that the new features will not negatively affect performance of the app. Users therefore should not experience any slow-downs caused by the update. If you do, please let us know through our [support portal](https://support.decisionrules.io/).
{% endhint %}

We believe that the user will eventually find these changes useful and helpful in their work.

### Output Cells

By output cells, we mean all cells in the output (result) columns. Prior to this version, the user could choose between two types of the output cells: simple value and function. However, both of them yield almost the same results for simple value entries like strings or numbers. Any expression can be entered just using the function type output cell. The simple value cell therefore did not have much purpose.

The simple value output cell has now been deprecated. In effect, it is no longer possible to create new simple value output cells in your table. They are of course still supported in existing decision tables (the tables will still work the same). Upon clicking the = operator denoting the simple value output cell, the user can choose to switch that cell, or the whole column, to the function type. Note that function type output cells lost their operator symbol, as they are now considered the default type.

{% hint style="warning" %}
There are some special values for which the function type and the simple type of output cells produce slightly or even significantly different results. In most cases, switching the cell type should be fine. Nevertheless, we still recommend to retest your table if you decide to switch to the function type (even more so upon switching the whole column). If you are not sure or you do not want to retest, you can always just leave the simple value as it is.
{% endhint %}

Note that when switching from the simple value cell to the function cell, the wizard wraps the cell value in double quotes. This is done on purpose. There are some characters which have a special meaning in the function cells, namely

```
+ // Plus
- // Minus
* // Times
/ // Divided by
% // Percent
```

If the cell value contains these characters, it is necessary for it to be wrapped in single or double quotes.  That way, the value will be interpreted as string.

{% hint style="info" %}
When entering values in the default output column cells, beware of the special characters. If you want the expression to be interpreted as string, wrap it in single or double quotes.
{% endhint %}

### Date Cells

Date cell is a specific kind of cell accompanying the [date operators](../decision-tables/operators/date-operators.md). It allows to enter dates in order to build a date condition. Up to now, date cells featured a date picker. It was not able to copy paste the dates or write them in a text form.

With the new version of the app,  date cells got an important update. All the dates entered in the new date cells are now primarily represented as string. Therefore they can be more easily edited and copy pasted between the cells. In edit mode, date cells show an info line telling you how the entered value will be interpreted.

Up to now, the date cells allowed to enter only date with timezone, only time with timezone or even only timezone. The same logic is still in place. Among other supported date formats, there are several special ones that allow to enter this partial information. See the overview below.

```
YYYY-MM-DD HH:mm TZ      // Full date, e.g. 2024-05-15 01:25 +00:00
YYYY-MM-DD HH:mm:ss TZ   // Full date with seconds, e.g. 2024-05-15 01:25:02 +00:00
YYYY-MM-DD TZ            // Date only, e.g. 2024-05-15 +00:00
HH:mm TZ                 // Time only, e.g. 01:25 +00:00
HH:mm:ss TZ              // Time with seconds only, e.g. 01:25:02 +00:00
TZ                       // Timezone only, e.g. +00:00 (Not recommended)
```

{% hint style="info" %}
Dates from already existing tables are translated to one of the above formats. This change should have no effect on the rule solve. Also, you can still use the time picker, if you want.
{% endhint %}

#### Behavior Changes

* Date cells with partial date are now matching partial dates entered on input in string format. This is a rather special case, but we want to point it out nonetheless. For example, consider the following date equal cell in old table:

<figure><img src="../.gitbook/assets/image (339).png" alt=""><figcaption><p>DATE EQUAL cell with partial date: the old table (on the left) and the new table (on the right)</p></figcaption></figure>

Now, matching this cell against the input `"14:30 +04:00"` previously yielded negative result, and the cell did not match. In the new version of the app, the inputted string is processed and the cell matches (as one would expect). Note that this change applies to all date operators, including DATE BETWEEN and others.

### Variables

There is an important change in how we are treating variables in the decision tables.

Up to now, the support of variables in decision tables was rather limited. You could use all variables (rule variables, input and output variables) in the function type cells. Rule variables (those defined in the settings) were in general recognized by the solver, but not always highlighted. Input variables were recognized in output columns but, for some reason, not in the input columns (e.g. matching two input variables using the = operator did not work). Output variables were recognized by the solver in the output columns but highlighted as invalid in simple value type of cells.

We decided to extend the support of all variables to all cells where it makes sense. That is, you can now use rule variables and input variables in all columns/cells across the table, no matter the kind of cell. You can also use output variables in all columns placed to the right of the defining column of the respective variable (in the rest of the table, the variable is not defined, and it therefore does not make sense to use it there).

In cells of function type, the interpretation of variables is the same as before. The value of that variable is interpreted as needed in the context of the function where it is used.

In cells of other than function type, the variables are interpreted as follows. If a cell contains only the variable, the solver attempts to directly use the value from that variable. For instance, if a variable contains an object, the solver uses the object directly in the cell. On the other hand, if the cell contains the variable wrapped with text, the solver converts the value in that variable to string and concatenates with the text around it.

{% hint style="warning" %}
Due to the extended support for variables, changes in behavior may occur. We recommend to retest the decision table if it featured variables not recognized by the solver (because they might be recognized in the new version, changing the behavior of the rule), when employing special characters in variable names, when using non-unique variable names, etc.
{% endhint %}

#### Behavior Changes

Below we give examples of behavior changes occurring for variables. These may be useful for understanding the possible impact on your rules.

* Input variables are now interpreted for the multi-value operators like IN (In), !IN (Not contains in), C IN (Contains in) etc. Previously this was not the case (the cell was simply considered falsy). Consider the following example: an IN cell of the form

<figure><img src="../.gitbook/assets/image (338).png" alt=""><figcaption><p>IN cell with a variable: the old table (on the left) and the new table (on the right)</p></figcaption></figure>

Assume that the `{in}` is an input variable, and the cell is in a condition column testing the value of another input variable `{ab}`.  Now, in the previous version of the app, this cell did not match even if both `{in}` and `{ab}` had the same value, for instance with the following input data:

```json
{
  "in": "ABC",
  "ab": "ABC"
}
```

On the contrary, in the new version of the app, the `{in}` variable gets processed by the cell (as one would expect), and the above input data lead to a match.

* Multiple distinct variables are parsed and evaluated. Consider for example a cell in a condition column with an input variable and a rule variable:

<figure><img src="../.gitbook/assets/image (340).png" alt=""><figcaption><p>Cell with two distinct variables</p></figcaption></figure>

In the prior versions, this condition would never work. Now it evaluates both the variables and yields true for matching values of the column variable.

### Valid Values

Up to now, there were two kinds of valid values: general and date. General valid values were used for cells corresponding to basic operators, while date valid values were used for date operators.

Since this version, date valid values are deprecated. There is only one generalized kind of valid values now. As a result of that, the general and date valid values set in decision tables prior to this version will now be merged together. Since dates are newly entered in the form of a string (see the Date Cells section above), they can be validated with the unified valid values.

{% hint style="info" %}
If you need advice on valid values in your table, you can turn to our [support portal](https://support.decisionrules.io/).
{% endhint %}

### Calculation Columns

In this version we are introducing a new major feature of decision tables, called calculation columns. Up to now, decision tables had just two kinds of columns: condition and result columns. A calculation column (or calc column, for short) is a new kind of column allowing to do custom calculations.

In the calculation column header, you specify the name of a new variable, defined by the column. We call it calc variable. The individual cells of that column then specify its values. From the nature of it, the calc variable can of course have different values for each row.

{% hint style="info" %}
The cells in calc columns are implicitly of the function type, just like in the result columns. It is therefore possible to switch between calculation and result column kinds. After all, these two kinds of columns are doing the same thing: setting variable values. The only difference is that result columns set the outputs, while calc columns set internal calc variables.
{% endhint %}

Calc variables can be used in any column to the right of their defining calc column. And this includes the conditions. It is thus possible to set up some custom values or make custom calculations, and then use these freely both in conditions and results. This opens new powerful capabilities for decision tables.

Unlike condition and result columns, calculation columns can be placed anywhere in the table. Just make sure that you define the calc variable before actually using it (place references to calc variables only to the right of their defining calc column).

{% hint style="warning" %}
As of now, tables with calculation columns cannot be compared. We will probably add this functionality in the future.
{% endhint %}

### Column Aliases

Columns have been provided with so-called column aliases. The column alias is a human-readable string uniquely identifying a column within the decision table. The aliases are auto-generated, but can be edited. You can find them under the column settings.

Column aliases are used in XLSX export (see section below).

Column aliases can be also used in [Solver API options](../api/rule-solver-api.md#options) to specify condition columns that should be included/excluded when solving the decision table.

### Excel and CSV Export Formats

There are major changes in the XLSX and CSV export/import formats of decision tables.

We are introducing a new XLSX import/export format labelled as version 2. It is designed to support all the new features, most importantly the calculation columns. Also, it has much better level of fidelity. Unlike the preceding XLSX version 1, it contains all transferable settings and data of the decision table, including valid values. The data are listed on several distinct sheets for better readability. The table in XLSX version 2 has simpler styling and is more easily editable.

Due to the update of the XLSX export/import format, the original XLSX version 1 is now deprecated. It is of course possible to import the tables exported in this format prior to the update. The export to XLSX version 1 is still available as well, but not recommended.

Starting with this version, the CSV export/import format is also deprecated. Tables exported to CSV prior to this version can be imported, and the export to CSV is also still allowed, but not recommended. We do not plan to continue to support this option in the future.

{% hint style="warning" %}
Deprecated export/import in CSV and XLSX version 1 may not work correctly for newly created tables. In particular, it will definitely not work for tables with calculation columns. We recommend to use the XLSX version 2.
{% endhint %}

## Decision Tree

Decision trees use some of the same components as decision tables in their conditions and results. Some of the changes described above for decision tables therefore apply to decision trees as well. This is the case of the above sections Table Cell Design, Date Cells, and Variables.

Apart from that, there are no other changes made to decision trees specifically.

## Workflow

Workflow is a brand new feature brought in version 1.19.0 of DecisionRules. It allows to design complex decisioning processes, similarly as in rule flows. However, workflow provides a much more powerful and versatile alternative.

{% hint style="info" %}
Workflow provides all the features of rule flow, and more. It is therefore possible that rule flows will be eventually deprecated in favor of workflows. That being said, current users of rule flows need not worry. Continual full support of rule flows will be provided.
{% endhint %}

Workflow can be used to orchestrate other rules, make data transforms and calculations, run inline scripts, perform conditional branching, call external API, and more. The list is not final. Workflow will be given even more capabilities, like DB connectors, integrations to 3rd party tools, etc.

For more detail on workflows, see the [Workflow](../workflow/workflow-introduction.md) section.

