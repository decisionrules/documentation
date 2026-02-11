# Rule Import

You can import rules individually, entire folders, or import the entire space. You can also update existing rules or create new versions of them.

## How to Import

### **Method 1:  Import as New Rule**

**Import from Rule List:**

1. Navigate to the **Rule Lists** section.
2. Select empty space or folder where you want to import the rule.
3. Click the **Import** button.
4. Select your file: **JSON** or **XLSX**.
5. Click the **Import** button.

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-10 at 11.49.06.png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-10 at 11.51.34.png" alt="" width="563"><figcaption></figcaption></figure>

{% hint style="warning" %}
The imported rule may have the same name as an existing rule, but it cannot have the same alias. If an alias conflict is detected, you will receive a warning.
{% endhint %}

### **Method 2:  Override Current Version**

1. Open the rule you want to overwrite.
2. Click the **three dots** in the top right corner to open **Rule Actions**.
3. Select **Import Version**.
4. Choose your import **Overwrite latest version** - Replaces the current version.
5. Select your file: **JSON** or **XLSX**.
6. Click the **Import** button.

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-10 at 12.04.53.png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-10 at 12.05.36.png" alt="" width="563"><figcaption></figcaption></figure>

{% hint style="info" %}
You can find all previous changes in the [history tab](../rule-history.md).
{% endhint %}

### **Method 3:  Import as New Version**

1. Open the rule you want to overwrite.
2. Click the **three dots** in the top right corner to open **Rule Actions**.
3. Select **Import Version**.
4. Choose your import **Import as new version** - Creates new version of rule you are importing with name and alias of current one.
5. Select your file: **JSON** or **XLSX**.
6. Click the **Import** button.

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-10 at 12.04.53.png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-10 at 12.09.38.png" alt="" width="563"><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/Screenshot 2026-02-10 at 12.11.03.png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
The imported rule's status depends on the `status` field in the exported file. More details about rule statuses, see [Rule Status](../rule-settings/rule-state.md).
{% endhint %}

## File Format Requirements

### JSON Format

#### Base Schema

Every rule import must include these mandatory fields:

```json
{
    "type": "rule-type",      // See rule-specific types below
    "name": "Rule Name",      // Any string
    "status": "published",    // "published" or "pending"
    "inputSchema": {},        // JSON object defining input structure
    "outputSchema": {}        // JSON object defining output structure
}
```

{% hint style="warning" %}
If no `ruleAlias` is specified in the import file, one will be generated automatically.
{% endhint %}

#### Rule Type-Specific Requirements

In addition to the base schema, each rule type requires specific additional fields:

***

**Decision Table**

```json
{
  "type": "decision-table",
  "decisionTable": {
    "columns": [],      // Array with at least one input column and one output column
    "rows": []          // Array of row data (can be empty)
  }
}
```

**Scripting Rule**

```json
{
    "type": "complex-rule",
    "script": {}         // String containing JavaScript code
}
```

**Lookup Table**

```json
{
    "type": "lookup-table",
    "primaryKeyColumn": {},   // Object defining the primary key column
    "columns": [],            // Array defining all table columns
    "data": {}                // List of objects containing table data rows (can be empty)
}
```

**Decision Flow**

```json
{
    "type": "workflow",
    "workflowData": {}    // Object containing flow structure and nodes
}
```

**Integration Flow**

```json
{
    "type": "integration-flow",
    "workflowData": {}    // Object containing integration flow structure and nodes
}
```

### **XLSX Format**

For detailed XLSX import specifications, see [Managing Decision Table in Excel/Google Sheets](managing-decision-table-in-excel-google-sheets.md)

### CSV Format

For detailed CSV import specifications, see [Lookup Table CSV Import](../../lookup-table/data-import-and-export.md)
