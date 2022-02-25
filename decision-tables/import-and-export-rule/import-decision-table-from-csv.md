---
description: Importing decision table from CSV file.
---

# Import Decision Table from CSV

## Import from CSV file

To import a decision table, sign in, then go to **Decision Tables** item in the sidebar menu. Next, click on ![](<../../.gitbook/assets/screenshoteasy (6) (1).png>) button.

![](<../../.gitbook/assets/image (65).png>)

#### Next, there are two options:

### 1. Import and create a new one

In this option, a new decision table is created after the decision table is imported. The new decision table will have a **new Rule Id,** and the version will be set to **1**.

1. Select **New rule**.
2. Drop or choose file with rule
3. Click on **Save**.

### 2. Import and override the existing decision table

In this option, after importing the rule, the selected rule with the selected version will be **overridden**. The imported rule, in this way, will have the same **Rule Id** and **version** as selected.

1. Select **Existing rule**.
2. Select **Rule** and **Version**.
3. Drop or choose file with rule
4. Click on **Save**.

{% hint style="danger" %}
The selected rule with selected version will be **overridden**. This cannot be **undone**. The only option is to [export the rule](export-decision-table.md) and then re-import it.
{% endhint %}

{% hint style="warning" %}
If the import is not successful or data are missing you will be notified by popup message and shown where is the problem in your table.
{% endhint %}
