# Import and Export Decision Trees

Decision Trees can be imported and exported in JSON format just as any kind of rules.

## Import Decision Tree

To import a Decision Tree, sign in, follow the **Decision Trees** link in the sidebar menu and click the ![](<../.gitbook/assets/screenshoteasy (6) (1).png>) button.

![](<../.gitbook/assets/image (92).png>)

#### Next, there are two options:

### 1. Import and create a new one

With this option, a new Decision Tree is created after the import. It will have a **new Rule Id,** and the version will be set to **1**.

1. Select **New rule**.
2. Drop or choose file with rule
3. Click on **Save**.

### 2. Import and override the existing Decision Tree

With this option, the selected rule with the selected version will be **overridden**. The imported rule will therefore have the same **Rule Id** and **version** as selected.

1. Select **Existing rule**.
2. Select **Rule** and **Version**.
3. Drop or choose file with rule
4. Click on **Save**.

{% hint style="danger" %}
The selected rule with selected version will be **overridden**. This cannot be **undone**. The only option is to [export the rule](../decision-tables/import-and-export-rule/export-decision-table.md) and then re-import it.
{% endhint %}

## Export Decision Tree

To import a Decision Tree, sign in and follow the **Decision Trees** link in the sidebar menu.

![](<../.gitbook/assets/dtd (2).jpg>)

**Next, there are two options:**

### **1.** Export Decision Tree from the list

1. Choose the Decision Tree to create a new version.
2. Click on ![](<../.gitbook/assets/screenshoteasy (5).png>) button.

### 2. Export Decision Tree from the rule detail

1. Choose the Decision Tree to export.
2. Click on the **name** of the selected Decision Tree.
3. The rule detail will be shown.
4. Click the ![](<../.gitbook/assets/screenshoteasy (5).png>) button.

The app creates a JSON file with a name containing the Decision Tree rule **name** and **version**. This file will start downloading to the computer automatically.
