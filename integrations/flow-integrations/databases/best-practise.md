---
description: >-
  This page provides design recommendations for working with databases in
  Integration Flow.
---

# Best Practise

## Multi-Row vs. Single-Row Nodes

DecisionRules provides two types of database query nodes for each supported database:

### **Multi-Row node**

* Returns all rows from the query result
* Exposes a **Loop Connector** to iterate over each row via `{nodeName.currentRow}`
* Best suited for `SELECT` statements that return multiple records you need to process one by one

### **Single-Row node**

* Returns only the **first row** from the result (or no row for non-SELECT queries)
* The result is immediately available as `{nodeName.row}` without looping
* Best suited for:
  * `INSERT`, `UPDATE`, `DELETE`, `CREATE`, and other non-returning statements
  * `SELECT` queries guaranteed to return exactly one record (e.g. lookup by primary key)
  * **Any operation involving** `CREATE TEMP TABLE` (see Technical Limits)

### Recommendation

Use **Single-Row nodes** whenever you do not need to iterate over multiple results. This keeps the flow simpler and, critically, ensures all your database operations within the flow share a single connection — which is a requirement for temporary table access.

Use **Multi-Row nodes** only when you genuinely need to loop through a result set row by row.

## Using Temporary Tables for Safe Data Persistence

When a flow needs to build up or transform data in the database before committing it to a final destination table, using a temporary table as intermediate storage is the recommended pattern.

```sql
CREATE TEMP TABLE tmp_results (
    col1 VARCHAR,
    col2 VARCHAR,
    col3 NUMBER
)
```

{% hint style="warning" %}
See [Technical Limits](technical-limits.md#temporary-tables) for important constraints on temporary tables.
{% endhint %}

### Why Temporary Tables?

* Each flow execution gets its own temporary table — if two users run the same flow simultaneously, their data is completely isolated.
* They are automatically dropped by the database engine when the session ends — no manual cleanup needed.
* If the flow fails midway, any partial data in the temporary table is discarded automatically. The final target table is never left in an inconsistent state.
* The flow can be safely re-run from scratch after a failure.

### Recommended Pattern

The flow starts by loading the source data, then creates the temporary table. A loop iterates over each row — processing it through any logic you need (assignments, calculations, business rules, or even subflow calls) and writing the result into the temp table.

**The final table is only written once** when all rows have been successfully processed. If anything fails during the loop, the temp table is abandoned and the final table is never touched.

<figure><img src="../../../.gitbook/assets/Screenshot 2026-04-09 at 14.37.49 1.png" alt=""><figcaption></figcaption></figure>



