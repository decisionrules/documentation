---
description: >-
  Welcome to the Lookup Tables section. This section provides comprehensive
  guidance on how to effectively utilize this powerful feature for managing
  reference data within your decision-making processes
---

# Lookup Table

### What Is a Lookup Table?

A **Lookup Table** is a structured way to store and retrieve reference data using a key-value approach. Unlike Decision Tables that evaluate conditions to produce results, a Lookup Table acts as a data repository where each row is uniquely identified by a **primary key**, allowing fast and efficient data retrieval.

Think of it as a database table or dictionary that your rules can query to fetch values. For example:

* **Product Catalog**: Look up product details by SKU or product code
* **Pricing Tables**: Retrieve prices based on product ID or tier
* **Customer Segments**: Get customer attributes by customer ID
* **Geographic Data**: Fetch regional settings by country or postal code
* **Configuration Settings**: Store application parameters indexed by setting name

<figure><img src="../../.gitbook/assets/image (5).png" alt="Lookup Table Overview"><figcaption><p>Lookup Table Overview</p></figcaption></figure>

### When to Use Lookup Tables

Lookup Tables are ideal when you need to:

* **Store reference data** that your Decision Tables, Decision Trees, or Flows need to query
* **Manage large datasets** that would be impractical to maintain within a Decision Table
* **Centralize data** used across multiple rules
* **Import/export data** easily via CSV or XLSX
* **Maintain data integrity** with primary key uniqueness enforcement

#### Lookup Tables vs. Decision Tables

| Feature         | Lookup Table                      | Decision Table                         |
| --------------- | --------------------------------- | -------------------------------------- |
| **Purpose**     | Store and retrieve reference data | Evaluate conditions and return results |
| **Structure**   | Primary key + data columns        | Condition columns + Result columns     |
| **Logic**       | Simple key-based lookup           | Complex conditional logic              |
| **Best for**    | Static reference data             | Business rules with if-then logic      |
| **Scalability** | Optimized for large datasets      | Best for moderate row counts           |

### What You Can Find in This Section

{% content-ref url="lookup-table-designer.md" %}
[lookup-table-designer.md](lookup-table-designer.md)
{% endcontent-ref %}

Learn how to create and edit Lookup Tables using the visual designer



{% content-ref url="using-lookup-tables-in-rules.md" %}
[using-lookup-tables-in-rules.md](using-lookup-tables-in-rules.md)
{% endcontent-ref %}

Query Lookup Tables from Decision Tables, Trees, and Flows.



{% content-ref url="data-import-and-export.md" %}
[data-import-and-export.md](data-import-and-export.md)
{% endcontent-ref %}

Import data via CSV, XLSX or JSON.



### Quick Start Example

Here's a simple example of a Product Pricing lookup table:

**Columns:**

| Column Name  | Alias         | Primary Key |
| ------------ | ------------- | ----------- |
| Product Code | product\_code | ✓           |
| Product Name | product\_name |             |
| Price        | price         |             |
| Category     | category      |             |

**Sample Data:**

| Product Code | Product Name | Price | Category    |
| ------------ | ------------ | ----- | ----------- |
| SKU-001      | Widget Pro   | 29.99 | Electronics |
| SKU-002      | Gadget Plus  | 49.99 | Electronics |
| SKU-003      | Tool Basic   | 15.00 | Hardware    |

When you query this table with `"primaryKey" = "SKU-001"`, you receive all the associated values for that row.

### Key Concepts

#### Primary Key

Every Lookup Table must have exactly one column designated as the **primary key**. This column:

* Must contain **unique values** — no duplicates allowed
* Cannot contain **empty values**
* Is used to **index and retrieve** rows efficiently
* Is **pinned to the left** side of the table for easy identification

#### Columns

Lookup Table columns define the structure of your data:

* **Name**: Human-readable label displayed in the header
* **Order**: Position of the column in the table

_Note: Lookup Table Columns are also defined by an **Alias -** a technical identifier which you should never have to interact with or change._

#### Rows

Each row in a Lookup Table represents a single record:

* Rows are uniquely identified by the primary key value
* All columns can contain data or be left empty (except the primary key)
* Row order is maintained but is not important when it comes to performance
