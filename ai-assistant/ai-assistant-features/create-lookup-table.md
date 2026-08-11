---
description: Create Lookup Table with AI
---

# Create Lookup Table

When you are on the Rules List, you can access the **Lookup Table Architect** within the AI Assistant. It lets you generate a Lookup Table from written, human-readable instructions.

A Lookup Table stores fixed reference data. Each row is identified by one primary key, which can be used to retrieve values from the other columns. For example, you can use a Lookup Table for product catalogs, country information, pricing references, customer classifications, or configuration values.

Unlike a Decision Table, a Lookup Table does not evaluate conditions or apply if-then logic.

<figure><img src="../../.gitbook/assets/image (434).png" alt=""><figcaption></figcaption></figure>

### How the Prompt Works

Describe the reference data you want to store and provide:

* **Purpose** – what the Lookup Table will contain or be used for
* **Primary key** – the column that uniquely identifies every row
* **Columns** – the values that should be available for each record
* **Rows** – the actual mappings or reference data

You do not need to define Input and Output model properties. The Assistant automatically prepares the structure required for querying the Lookup Table.

A good prompt clearly identifies the primary key and provides the expected columns and values.

### Creating a Lookup Table

1. Open the **Rules List**.
2. Open the **AI Assistant**.
3. Select **Lookup Table Architect** from the agent dropdown, or describe that you want to create a Lookup Table.
4. Enter your reference data and identify the primary key.
5. Answer any clarification question if essential information is missing.
6. Review the generated Lookup Table proposal.
7. Click **Import Rule** to add it to your space.

The Lookup Table is not created until you click **Import Rule**.

After importing, DecisionRules opens the generated Lookup Table. You can review its columns and values, make additional changes, and save it like any other Lookup Table.

<figure><img src="../../.gitbook/assets/image (435).png" alt=""><figcaption></figcaption></figure>

### Prompt Examples

#### Country Reference Data

> Create a Lookup Table containing country information.\
> Use `countryCode` as the primary key.\
> Include the columns `countryName`, `currency`, and `region`.
>
> Data:
>
> * CZ, Czech Republic, CZK, Europe
> * US, United States, USD, North America
> * JP, Japan, JPY, Asia

#### Product Pricing

> Create a product pricing Lookup Table.\
> Use `productCode` as the primary key.\
> Include `productName`, `category`, and `price`.
>
> Data:
>
> * SKU-001, Widget Pro, Electronics, 29.99
> * SKU-002, Gadget Plus, Electronics, 49.99
> * SKU-003, Tool Basic, Hardware, 15.00

### Tips for Better Results

* Explicitly identify which column should be the primary key.
* Ensure every primary-key value is unique.
* List all required columns.
* Provide the actual reference values instead of asking the Assistant to invent them.
* Use consistent formats for dates, numbers, codes, and other values.
* For large datasets, create the Lookup Table structure first and then use CSV or XLSX import.

{% hint style="info" %}
Every Lookup Table must have exactly one primary-key column. Primary-key values must be unique and cannot be empty.
{% endhint %}

### Lookup Table or Decision Table?

Use a **Lookup Table** when one key should retrieve fixed reference values.

Examples:

* Retrieve a currency using a country code
* Retrieve a product price using a product ID
* Retrieve regional settings using a region code

Use a **Decision Table** when the result depends on conditions or business rules.

Examples:

* Approve an application based on age and credit score
* Calculate risk based on transaction attributes
* Select a discount based on customer status and order value

Read more about the differences in the [Lookup Table documentation](../../rules/lookup-table/).

{% hint style="warning" %}
The Lookup Table Architect creates new Lookup Tables. It does not currently edit existing Lookup Tables through AI Assistant.
{% endhint %}
