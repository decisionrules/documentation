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
Valid Values **apply to simple cells only**.

Valid values **do NOT apply** when a cell is set to **function mode**.

Valid values **cannot be set** for **calculated columns** (calc columns are always in function mode).
{% endhint %}

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
