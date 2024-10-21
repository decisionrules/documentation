---
description: Use the power of DecisionRules in Excel using our Excel Add-in.
---

# Excel Add-in

## What is an Excel Add-in?

An Excel add-in is a tool that you can add to Microsoft Excel to extend its capabilities. Specifically, the DecisionRules Excel Add-in allows you to solve your rules defined in DecisionRules with the data from your Excel sheets. It also writes the solved data into a new sheet, making it easy to analyse and use the results directly within Excel.

## How to install the DecisionRules Excel Add-in?

1. **Open Excel** and **create a new sheet**.
2. In Excel, navigate to the **Home** tab. On the **toolbar** _(ribbon)_, find the button labeled **Add-ins** and click on it. This will open a pop-up window.
3. In the bottom right corner of the pop-up window, click on the button labeled **More Add-ins.** This will open the Office Add-ins store.
4. In the search bar, type the name of the Excel Add-in, in this case <mark style="color:purple;">**DecisionRules**</mark>, and press **Enter** to search.
5. Find the add-in in the search results and click on the **Add** button next to the add-in.
6. Follow any additional prompts to complete the installation.
7. And thats it! The DecisionRules Excel Add-in icon should appear on the right side of the **toolbar** in the **Home tab**.

## Getting started with the DecisionRules Add-in

The DecisionRules Excel Add-in is divided into 2 main parts. The **Tutorial** and the **Custom Solver**.

* **Tutorial** is used to showcase the solving process and capabilities of the Add-in. It should be used by users who are new to the Add-in.
* **Custom Solver** allows you to solve your custom defined business rules in DecisionRules using data from your Excel sheets.

## How to use the Custom Solver?

This guide will walk you through using the **Custom Solver** in the DecisionRules Excel Add-in.

### Step 1: Prepare Your Excel Data

Before you begin, ensure that the data you want to use is organized in your Excel sheet. Each column should represent a specific type of information that matches the input requirements of your DecisionRules rule (e.g., product type, period, promo code).

<div align="left">

<figure><img src="../.gitbook/assets/image (361).png" alt=""><figcaption></figcaption></figure>

</div>

In the example image above, you can see that there are 3 types of data (productType, period and promoCode). The header column (purple row) with the data key is not necessary, but can be used to leverage the autocomplete feature (we will talk more about this feature in the column mapping step)

### Step 2: Configure the Add-in (Configuration Tab)

1. Head over to [https://app.decisionrules.io/](https://app.decisionrules.io/) and select the rule you would like to solve using the Excel Add-in.
2. Once in the rule, click on the "Integrations" tab.\
   <img src="../.gitbook/assets/image (360).png" alt="" data-size="line">
3.  In the Integration tab, click on "Excel" and copy the JSON configuration.\


    <div align="left">

    <figure><img src="../.gitbook/assets/image (10).png" alt="" width="377"><figcaption></figcaption></figure>

    </div>
4. Start the DecisionRules Excel Add-in and head over to the Custom Solver section.\
   ![](<../.gitbook/assets/image (1).png>)
5. In the **Excel Integration Configuration (JSON)** section, paste the copied  JSON configuration.\
   ![](<../.gitbook/assets/image (12).png>)
6. After pasting the configuration, click the **"Setup Configuration"** button.

This configuration connects your Excel sheet to the DecisionRules API, defines the rule to be solved, and specifies the input schema required.

### Step 3: Map Excel Columns (Mapping Tab)

1. Go to the **Column Mapping Tab**.\
   ![](<../.gitbook/assets/image (2).png>)
2. In the mapping table, match the **Data Key** to the corresponding **Excel Column**. In the section one, we ordered the data in the order so that:
   * **productType** → Column **A**
   * **period** → Column **B**
   * **promoCode** → Column **C**
3. After mapping the columns, the mapping table should look like this:\
   <img src="../.gitbook/assets/image (5).png" alt="" data-size="original">
4. After completing the column mapping, click the **"Configure Mapping"** button.

Alternatively, you can use the **Autocomplete** feature:

1. Select the relevant data area in your Excel sheet.
2. Ensure that the first row in your selection corresponds to the keys from the input schema.
3. Click "Autocomplete" to automatically map the columns.

### Step 4: Select Rows (Row Selection Tab)

1. Go to the **Row Selection Tab**.\
   ![](<../.gitbook/assets/image (6).png>)
2. In the “Rows” input, specify the rows you want to solve:
   * A single row: **1**
   * A range of rows: **1:3** _(rows 1 to 3 - the range is indicated by ":")_
   * A combination of rows: **1;3:5;7** _(rows 1, 3 to 5 and 7 - the combination is indicated by ";")_
3. After mapping the columns, the mapping table should look like this:\
   ![](<../.gitbook/assets/image (8).png>)

### Step 5: Solve the Rule

Once you’ve mapped your columns and selected your rows, click the **"Solve Rule"** button. The Add-in will create a new sheet named _**\<INPUT-SHEET-NAME>**_**-Output** (for example **DR-Example-Input-Output)** containing the results.

By following these steps, you can easily solve custom rules from DecisionRules using data from your Excel sheet.

## Additional features

### Configuration Profiles

Once you’ve used the custom solver, you might need to work with multiple DecisionRules rules, each requiring a different configuration. This is where Configuration Profiles come into play. A Configuration Profile is a predefined Excel Integration Configuration (in JSON format) that you can create once and reuse multiple times, ensuring faster and more efficient use.

To **access the configuration profiles**, go to the **Custom Solver Config Tab**. Next to the "Configuration Profile" input, click the "Manage" button. Here you can create new profiles, updating existing ones, or deleting profiles you no longer need. Each profile consists of a unique name, a JSON configuration provided by DecisionRules, and optional default column mappings to simplify data integration.\
![](<../.gitbook/assets/image (13).png>)

## Supported Excel Versions

The DecisionRules Excel Add-in currently supports the following versions of Excel:

* Excel on Windows & Mac (Microsoft 365)&#x20;
* Excel 2019 or later on Windows&#x20;
* Excel 2016, 2019 or later on Mac&#x20;
* Excel on the web&#x20;
* Excel on iPad





