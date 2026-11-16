# Valid Values

The Valid Values feature in Decision Tables plays a crucial role in maintaining the integrity and accuracy of your data. By restricting cell entries to a predefined set of valid options, you can prevent errors and ensure consistency across your decision-making processes.

Valid values can be defined in three ways:

1. **Value** - A predefined list of allowed values in specific column.
2. **Regex** - Pattern-based validation using regular expressions.
3. **Lookup Table Reference** - Values from another Lookup Table.

This functionality enhances the reliability of your tables, streamlines data entry, and establishes clear guidelines for data input, fostering a more dynamic and responsive decision-making environment.

## How to Apply Valid Values

1. Click the **arrow icon** in the header of the column.
2. Select **Valid Values**.

<figure><img src="../../../../.gitbook/assets/Screenshot 2026-02-11 at 15.17.46.png" alt="" width="555"><figcaption></figcaption></figure>

3. A modal will open with three validation type tabs: **Value**, **Regex**, and **Lookup Table Reference**.

<figure><img src="../../../../.gitbook/assets/Screenshot 2026-02-12 at 13.29.05.png" alt="" width="563"><figcaption></figcaption></figure>

4. Choose your validation type and configure it (see sections below).
5. Click **Save values** to apply.

{% hint style="warning" %}
In condition and result columns, Valid Values **apply to simple cells only**.

Valid values **do NOT apply** when a cell is set to **function mode**.
{% endhint %}

### Valid Values in Calculation Columns

From version **1.28.0**, Calculation columns offer **Valid Values** in the same column menu as other columns, with the same three validation types.

A calculation cell is always a function, so the text of the function is compared with the valid values. A cell whose text does not match is highlighted as invalid, but it stays in the table and the rule still evaluates the function exactly as before: valid values never change the result of a calculation. For example, with the valid values `1`, `2` and `3`, the cell `SUM(1,10)` is highlighted, and the column still returns `11`.

A list of values or a Lookup Table Reference shows the usual dropdown of choices. A regular expression keeps direct text entry and shows no dropdown. Removing the valid values removes the restriction without changing any cell.

### **Validation Type 1: Value (Predefined List)**

Define a specific list of allowed values for the column.

**How to set up:**

1. Open the Valid Values modal.
2. Select the **Value** tab.
3. Type valid value and **press Enter to confirm**.
4. Repeat for all allowed values.
5. Click **Save values**.

<figure><img src="../../../../.gitbook/assets/Screenshot 2026-02-12 at 13.29.45.png" alt="" width="563"><figcaption></figcaption></figure>

Once valid values are applied, every cell (except for functions) in the column is checked against the predefined list. If a cell contains an invalid value, it will be flagged.

<figure><img src="../../../../.gitbook/assets/Screenshot 2026-02-11 at 15.32.56.png" alt="" width="554"><figcaption></figcaption></figure>

Additionally, when valid values are set, you cannot directly type into the cells in that column. Instead, a dropdown with the list of valid values will appear when you click on a cell, allowing you to select the appropriate value.

<figure><img src="../../../../.gitbook/assets/Screenshot 2026-02-12 at 8.49.45.png" alt="" width="563"><figcaption></figcaption></figure>

{% hint style="success" %}
You can use not just simple values, but also variables, dates, or even full expressions as valid values. Spaces and operators are also allowed within a valid value.
{% endhint %}

<figure><img src="../../../../.gitbook/assets/Screenshot 2026-02-12 at 13.30.30.png" alt="" width="563"><figcaption></figcaption></figure>

### **Validation Type 2: Regex (Pattern Matching)**

Use regular expressions to validate cell values against a pattern.

**How to set up:**

1. Open the Valid Values modal.
2. Select the **Regex** tab.
3. Enter your regular expression in the **Expression** field. Examples:
   1. Email validation `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$`
   2. Phone (US) `^\d{3}-\d{3}-\d{4}$`
   3. Postal Code `^\d{5}(-\d{4})?$`
   4. Alphanumeric `^[A-Za-z0-9]+$`
4. Test your regex:

* Enter a test string in the **Test String** field.
* Click **Test Regex** to verify if the pattern matches.

5. Click **Save values**.

<figure><img src="../../../../.gitbook/assets/Screenshot 2026-02-12 at 8.33.37.png" alt="" width="563"><figcaption></figcaption></figure>

<figure><img src="../../../../.gitbook/assets/Screenshot 2026-02-12 at 8.35.16.png" alt="" width="563"><figcaption></figcaption></figure>

For more information about regular expressions and pattern syntax, see:

* [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_expressions)
* [Regex101](https://regex101.com/)

### **Validation Type 3: Lookup Table Reference**

Validate values against data from a Lookup Table in your space.

**For detailed information** about Lookup Table References and how they work, see [Lookup Table Reference](../../../lookup-table/using-lookup-tables-in-rules.md)

#### Filtering the Choices

From version **1.28.0**, a Lookup Table Reference can narrow the choices of each row. In the **Lookup Table Reference** tab, after selecting the Lookup Table and its matching column:

1. In **Filter Column**, select the Lookup Table column to compare.
2. In **Filter Source**, choose where the value to compare comes from:
   * **Column in this table** — the value in another column of the same row. The source can be a condition, calculation or result column, and it needs no valid values of its own.
   * **Static value** — a fixed value that you enter. It is stored exactly as typed.
3. Click **Save values**.

The dropdown of each row then offers only the Lookup Table records whose Filter Column equals the source value. Filters can be chained: a filtered column can itself be the source of the next column's filter. To remove the filter, clear **Filter Column**; the Lookup Table Reference stays.

How the source value is read:

* A condition cell used as the source supports the operators `=`, `IN`, `!=`, `<>` and `NOT IN` with literal values. `IN` offers the records that match any of its values; the negative operators offer the records that match none of them.
* A cell in function mode, any other operator, and an empty source leave the dropdown unrestricted. A plain rule variable such as `{region}` is resolved to its value.
* The comparison is exact: letter case, spaces and quote characters count, and numbers and `true`/`false` are compared by type, so `100` matches the number `100` but `"100"` does not.

Filtering only limits the choices in the editor. It never changes a cell: a saved value that no longer fits the filter stays in the cell and is highlighted as invalid. Solving the rule is not affected.

{% hint style="info" %}
The modal does not let a column filter itself or create a circular dependency between columns. If you delete a column that other columns use as their filter source, those filters are cleared; undo restores the column together with its filters.
{% endhint %}
