---
description: Set of possible values in which can be in the particular columns
---

# Valid Values

## Valid Values in Decision Table

The **Valid Values** feature in DecisionTables plays a crucial role in maintaining the integrity and accuracy of your data. By restricting cell entries to a predefined set of valid options, you can prevent errors and ensure consistency across your decision-making processes. This functionality not only enhances the reliability of your tables but also streamlines data entry, making it easier for users to select the correct values without the risk of input errors.

Incorporating valid values can significantly improve collaboration within teams, as it establishes clear guidelines for data input. With the ability to manage and update valid values seamlessly, users can adapt their decision tables to meet evolving requirements, fostering a more dynamic and responsive decision-making environment.

By leveraging the **Valid Values** functionality effectively, you can optimize your use of DecisionRules, ensuring that your decision tables are not only accurate but also aligned with your organization's standards and objectives.

## How to Apply Valid Values

<figure><img src="../../.gitbook/assets/valid values menu.png" alt="" width="282"><figcaption></figcaption></figure>

1. **Access Valid Values**: Click the arrow icon in the header of the column, then select **Valid Values**.
2. **Set Valid Values**: In the modal that opens, type the valid values you want to apply to the column. Press **Enter** to confirm each value.
   * To remove a value, click the cross icon next to it.
3. **Confirm Values**: Once your values are set, click the **Save values** button to confirm.

{% hint style="success" %}
You can use not just numbers or strings, but also variables, dates, or even full expressions as valid values.&#x20;

Spaces and operators are also allowed within a valid value.
{% endhint %}

<figure><img src="../../.gitbook/assets/valid values modal.png" alt=""><figcaption></figcaption></figure>

## Managing Valid Values

* When a column has valid values set, a valid values icon <img src="../../.gitbook/assets/image (1) (1) (1).png" alt="" data-size="line"> will appear in the column header.
* To update the valid values, click the valid values icon in the column header to reopen the modal. You can then add new values or remove existing ones.
* To remove valid values completely, click the cross icon at the end of the input field.

## Valid Values in Action

Once valid values are applied, every cell in the column is checked against the predefined list. If a cell contains an invalid value, it will be flagged.

<figure><img src="../../.gitbook/assets/invalid value.png" alt="" width="238"><figcaption></figcaption></figure>

Additionally, when valid values are set, you cannot directly type into the cells in that column. Instead, a dropdown with the list of valid values will appear when you click on a cell, allowing you to select the appropriate value.

<figure><img src="../../.gitbook/assets/valid values dropdown.png" alt="" width="306"><figcaption></figcaption></figure>

