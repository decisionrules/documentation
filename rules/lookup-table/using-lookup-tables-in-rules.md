---
description: >-
  Lookup Tables become truly powerful when integrated with other rule types.
  This section explains how to query Lookup Tables from Decision Tables,
  Decision Trees, Flows, and Scripting Rules.
---

# Using Lookup Tables in Rules

### Overview

Lookup Tables provide reference data that your rules can query during evaluation. Instead of hardcoding values in your decision logic, you can:

* Store data centrally in a Lookup Table
* Query the table dynamically based on input values
* Keep your rules clean and your data maintainable

### LOOKUP Functions

#### LOOKUP\_VALUE

The primary way to query a Lookup Table is using the `LOOKUP_VALUE` function available in Decision Tables, Decision Trees and assorted Flow nodes (e.g. Assign, Global Variable, etc...).

#### Syntax

```
LOOKUP_VALUE(rule-alias, primaryKey, version?, outputColumn?)
```

| Parameter         | Description                                                                                       |
| ----------------- | ------------------------------------------------------------------------------------------------- |
| `tableAlias`      | The alias (or id) of the Lookup Table to query                                                    |
| `primaryKeyValue` | The value to search for in the primary key column                                                 |
| `version`         | The version of the Lookup Table to query (latest published version is used when omitted)          |
| `outputColumn`    | <p>The name of the column to return. <br>When omitted the entire row is returned as an object</p> |

#### Return Value

* Returns the row or the value from the specified column where the primary key matches
* Returns `null` if no matching row is found
* Returns `null` if the column doesn't exist

#### Example

Given a Lookup Table with alias `product-catalog`:

| product\_code (PK) | product\_name | price | category    |
| ------------------ | ------------- | ----- | ----------- |
| SKU-001            | Widget Pro    | 29.99 | Electronics |
| SKU-002            | Gadget Plus   | 49.99 | Electronics |

**Query:**

```
LOOKUP_VALUE("product-catalog", {input.productCode}, null, "price")
```

**With input `{productCode: "SKU-001"}`:**

* Returns: `29.99`

**With input `{productCode: "INVALID"}`:**

* Returns: `null`

#### LOOKUP\_EXISTS

Returns a boolean (true/false) depending on if the entered primary key is present in the queried Lookup Table

#### Syntax

```
LOOKUP_EXISTS(rule-alias, primaryKey, version?)
```

| Parameter         | Description                                                                              |
| ----------------- | ---------------------------------------------------------------------------------------- |
| `tableAlias`      | The alias (or id) of the Lookup Table to query                                           |
| `primaryKeyValue` | The value to search for in the primary key column                                        |
| `version`         | The version of the Lookup Table to query (latest published version is used when omitted) |

#### Return Value

* Returns boolean
* Returns `true` if a row exists with the queried PK
* Returns `false` if no matching row (PK value) is found

#### Example

Given a Lookup Table with alias `product-catalog`:

| product\_code (PK) | product\_name | price | category    |
| ------------------ | ------------- | ----- | ----------- |
| SKU-001            | Widget Pro    | 29.99 | Electronics |
| SKU-002            | Gadget Plus   | 49.99 | Electronics |

**Query:**

```
LOOKUP_EXISTS("product-catalog", {input.productCode})
```

**With input `{productCode: "SKU-001"}`:**

* Returns: `true`

**With input `{productCode: "SKU-055"}`:**

* Returns: `false`

***

### Integration with Decision Tables and Trees

#### Using LOOKUP functions in Conditions and Results

You can use both LOOKUP functions in condition, calculation or result columns of a Decision Table or branches of a Decision Tree

### Using Lookup Tables with Valid Values

Lookup Tables can serve as a data source for **Valid Values** in Decision Table columns. This allows you to restrict cell entries to values from a Lookup Table, ensuring data consistency and reducing input errors.

#### Setting Up a Lookup Table Reference

1. Open your Decision Table in the Table Designer
2. Click the dropdown arrow in the column header
3. Select **Valid Values**
4. Choose **Lookup Table Reference**
5. Select the Lookup Table and the column to use as the value source

<figure><img src="../../.gitbook/assets/image (363).png" alt=""><figcaption></figcaption></figure>

Once configured, each cell in the column displays a dropdown with values from the referenced Lookup Table.

**Display Values**

You can configure a **display value** to show a more readable label in the dropdown while storing a different value in the cell. This is useful when you want to select by one attribute but store another.

**Example:** Display product names in the dropdown, but store the product code when selected.

<figure><img src="../../.gitbook/assets/image (365).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Display values make it easier to work with technical identifiers like codes or IDs by showing human-readable labels during selection.
{% endhint %}

***

### Integration with Decision Flows

In Decision Flows, you can use the **Business Rule** node to call the Lookup Table directly.

Or use the afformentioned LOOKUP\_VALUE and LOOKUP\_EXISTS functions in any Flow node that supports it. (e.g.: Assign, Declare, Global Variable, etc...)

***

### Integration with Scripting Rules

No special Lookup function is yet implemented in Scripting Rules or Custom Code nodes of a Flow. Please use DR.Solve() to call Lookup tables in these cases.

***

### Best Practices

#### Use Meaningful Aliases

Choose clear, descriptive aliases for your Lookup Tables:

```
✅ "product-catalog"
✅ "customer-tiers"
✅ "shipping-rates"

❌ "table1"
❌ "data"
❌ "lt"
```

#### Consider Performance

**Performance Optimization**: When you query the same Lookup Table multiple times within a single rule evaluation — such as in a loop or across multiple conditions in a Decision Table — the table is automatically cached. This means **each subsequent lookup is extremely fast**, so feel free to use multiple LOOKUP calls without concern for performance.

***

### Common Patterns

#### Pattern 1: Product Enrichment

Enrich order data with product information:

```
Input: {orderId: "123", items: [{sku: "SKU-001", qty: 2}]}

Output: {
  orderId: "123",
  items: [{
    sku: "SKU-001",
    name: LOOKUP("products", "SKU-001", "name"),
    unitPrice: LOOKUP("products", "SKU-001", "price"),
    qty: 2
  }]
}
```

#### Pattern 2: Tiered Pricing

Apply different pricing based on customer tier:

```
1. Lookup customer tier
2. Lookup discount rate for tier
3. Apply discount to product price

tier = LOOKUP("customers", {customerId}, "tier")
discount = LOOKUP("tier-discounts", {tier}, "discount_rate")
finalPrice = {basePrice} * (1 - {discount})
```

#### Pattern 3: Geographic Configuration

Retrieve settings based on location:

```
taxRate = LOOKUP("tax-rates", {input.countryCode}, "rate")
currency = LOOKUP("country-settings", {input.countryCode}, "currency")
shippingZone = LOOKUP("shipping-zones", {input.postalCode}, "zone")
```

#### Pattern 4: Feature Flags

Control features based on configuration:

```
featureEnabled = LOOKUP("feature-flags", "new-checkout", "enabled")

IF {featureEnabled} = true
  → Use new checkout flow
ELSE
  → Use legacy checkout flow
```
