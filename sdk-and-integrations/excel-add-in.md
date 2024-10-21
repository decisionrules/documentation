---
description: Use the power of DecisionRules in Excel using our Excel Add-in.
---

# Excel Add-in

## What is an Excel Add-in?

An Excel add-in is a tool that you can add to Microsoft Excel to extend its capabilities. Specifically, the DecisionRules Excel Add-in allows you to solve your rules defined in DecisionRules with the data from your Excel sheets. It also writes the solved data into a new sheet, making it easy to analyse and use the results directly within Excel.

## How to install the Excel Add-in?

1. **Open Excel** and **create a new sheet**.
2. In Excel, navigate to the **Home** tab. On the **toolbar** _(ribbon)_, find the button labeled **Add-ins** and click on it. This will open a pop-up window.
3. In the bottom right corner of the pop-up window, click on the button labeled **More Add-ins.** This will open the Office Add-ins store.
4. In the search bar, type the name of the Excel Add-in, in this case <mark style="color:purple;">**DecisionRules**</mark>, and press **Enter** to search.
5. Find the add-in in the search results and click on the **Add** button next to the add-in.
6. Follow any additional prompts to complete the installation.
7. And thats it! The DecisionRules Excel Add-in icon should appear on the right side of the **toolbar** in the **Home tab**.

## Getting started with the Add-in

The DecisionRules Excel Add-in is divided into 2 main parts. The tutorial and the custom solver.

(!!!) In this section, explain the add-in in general, dont explain the tutorial, the user will walk trough it

## How to use the Excel Add-in?

This guide will walk you through using the **Custom Solver** in the DecisionRules Excel Add-in. With this tool, you can solve your custom rules defined in DecisionRules using data from your Excel sheet.

### Step 1: Prepare Your Excel Data

Before you begin, ensure that the data you want to use is organized in your Excel sheet. Each column should represent a specific type of information that matches the input requirements of your DecisionRules rule (e.g., product type, period, promo code).

<figure><img src="../.gitbook/assets/image (361).png" alt=""><figcaption></figcaption></figure>

In the example image above, you can see that there are 3 types of data (productType, period and promoCode). The header column (purple row) with the data key is not necessary, but can be used to leverage the autocomplete feature (we will talk more about this feature in the column mapping step)

### Step 2: Configure the Add-in (Configuration Tab)

1. Head over to [https://app.decisionrules.io/](https://app.decisionrules.io/) and select the rule you would like to solve using the Excel Add-in.
2. Once in the rule, click on the "Integrations" tab.\
   <img src="../.gitbook/assets/image (360).png" alt="" data-size="line">
3. In the Integration tab, click on "Excel" and copy the JSON configuration.

#### Step 2:&#x20;

1. Navigate to the **Config Tab** in the Excel Add-in.
2. In the **Excel Integration Configuration (JSON)** section, paste the following JSON configuration:

```json
{
  "solverKey": "SECRET_API_KEY",
  "url": "https://api.decisionrules.io",
  "ruleAlias": "excel-addin-example",
  "version": "1",
  "debug": false,
  "strategy": "standard",
  "inputSchema": {
    "productType": {},
    "period": {},
    "promoCode": {}
  }
}
```

3. After pasting the configuration, click the "Setup Configuration" button.

This configuration connects your Excel sheet to the DecisionRules API, defines the rule to be solved, and specifies the input schema required.

#### Step 3: Map Excel Columns (Column Mapping Tab)

1. Go to the **Column Mapping Tab**.
2. In the mapping table, match the **Data Key** to the corresponding **Excel Column**. For example:
   * **productType** → Column **A**
   * **period** → Column **B**
   * **promoCode** → Column **C**

Alternatively, you can use the **Autocomplete** feature:

1. Select the relevant data area in your Excel sheet.
2. Ensure that the first row in your selection corresponds to the keys from the input schema.
3. Click "Autocomplete" to automatically map the columns.

#### Step 4: Select Rows (Row Selection Tab)

1. Go to the **Row Selection Tab**.
2. In the “Rows” input, specify the rows you want to solve:
   * A single row: **1**
   * A range of rows: **1:3**
   * A combination of rows: **1;3:5;7**

#### Step 5: Solve the Rule

Once you’ve mapped your columns and selected your rows, click the **"Solve Rule"** button. The Add-in will create a new sheet named **DR-Example-Input-Output** containing the results.

By following these steps, you can easily solve custom rules from DecisionRules using data from your Excel sheet.



### Additional features

* Configuration Profiles
* Autocomplete





