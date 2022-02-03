---
description: Importing decision table from XLSX file.
---

# Import Decision Table from XLSX

## Import from XLSX file

{% hint style="info" %}
For more information about Decision Tables management in Excel or Google Sheets click [**here**](../manage-tables-excel-gsheets.md)\*\*\*\*
{% endhint %}

To import a decision table, sign in, then go to **Decision Tables** item in the sidebar menu. Next, click on ![](<../../.gitbook/assets/screenshoteasy-6- (1).png>) button.

#### Next, there are two options:

### 1. Import and create a new one

![](<../../.gitbook/assets/image (67).png>)

In this option, a new decision table is created after the decision table is imported. The new decision table will have a **new Rule Id,** and the version will be set to **1**.

1. Select **New rule**.
2. Drop or choose file with rule
3. Click on **Save**.

### 2. Import to the existing decision table

![](<../../.gitbook/assets/image (113).png>)

In this option, after importing the rule, the selected rule with the selected version will be **overridden**. The imported rule, in this way, will have the same **Rule Id** as selected.

1. Select **Existing rule**.
2. Select **Rule** and **Version**.
3. In the **Version** are 3 options to choose from:
   1. **New Version -** a new version of the rule, non of the previous ones are overridden
   2. **Latest Version -** overrides the latest version of the rule
   3. **Version Choice** - the user can choose which version of the rule he wants to override
4. Drop or choose file with rule
5. Click on **Save**.

{% hint style="danger" %}
The selected rule with the selected version will be **overridden**. This cannot be **undone**. The only option is to [export the rule](export-decision-table.md) and then re-import it.
{% endhint %}

{% hint style="warning" %}
If the import is not sucesfull or data are missing you will be notified by popup message and shown where is the problem in your table.
{% endhint %}

### File Information

{% hint style="info" %}
More information is in [Import & Export](./) section.
{% endhint %}
