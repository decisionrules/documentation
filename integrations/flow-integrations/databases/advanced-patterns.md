---
description: >-
  This page covers techniques for specific scenarios that go beyond the standard
  recommended approach. These are not default patterns — use them when the
  situation calls for it.
---

# Advanced Patterns

## Writing All Results at Once

By default, writing data inside a loop means one INSERT per row — one database round-trip per iteration. If you need to write all results in a single query, you can use the [Collect](https://docs.decisionrules.io/doc/rules/flow/flow-nodes-overview#collect) node to gather all processed rows into a single array during the loop, then pass `{collect.value}` into one final write node after the loop completes.

#### **PostgreSQL**

```sql
INSERT INTO target_table (col1, col2)
SELECT r->>'col1', r->>'col2'
FROM json_array_elements('{collect.value}'::json) AS r
```

#### **SQL Server**

```sql
INSERT INTO target_table (col1, col2)
SELECT col1, col2
FROM OPENJSON('{collect.value}')
WITH (col1 VARCHAR(100) '$.col1', col2 VARCHAR(100) '$.col2')
```

#### **MySQL** _(8.0+)_

```sql
INSERT INTO target_table (col1, col2)
SELECT col1, col2
FROM JSON_TABLE('{collect.value}', '$[*]'
    COLUMNS (col1 VARCHAR(100) PATH '$.col1', col2 VARCHAR(100) PATH '$.col2')
) AS r
```

#### **Oracle** _(12c+)_

```sql
INSERT INTO target_table (col1, col2)
SELECT col1, col2
FROM JSON_TABLE('{collect.value}', '$[*]'
    COLUMNS (col1 VARCHAR2(100) PATH '$.col1', col2 VARCHAR2(100) PATH '$.col2')
)
```

#### **Snowflake**

```sql
INSERT INTO target_table (col1, col2)
SELECT r.value:col1::VARCHAR, r.value:col2::VARCHAR
FROM TABLE(FLATTEN(input => PARSE_JSON('{collect.value}'))) r
```

{% hint style="warning" %}
**Collect** holds all items in memory for the duration of the Flow. It is not suitable for large datasets — if you are processing a large number of rows, use the temporary table pattern instead.
{% endhint %}

## Sharing Data Across Flow Boundaries

Temporary tables are session-scoped — they cannot be accessed outside the flow that created them. When your main flow calls subflows that each need to contribute data to the same destination, a **permanent staging table** is the only way to share a writable workspace across flow boundaries.

### How It Works

The main flow owns the staging table lifecycle — it creates it at the start and performs the final write at the end. Subflows at any level write into the staging table freely, since it persists in the database and is visible to all connections sharing the same `correlationId`.

### Using `correlationId` as the Table Name

DecisionRules assigns a unique `correlationId` to every external flow call. Crucially, when a main flow calls subflows, they all share the same `correlationId` — making it a perfect built-in key for naming the staging table. No extra input parameters needed, and no risk of two executions colliding.

#### **Create staging table at the start of main flow (Single-Row):**

```sql
CREATE TABLE staging_{correlationId} (
    reservation_id VARCHAR(50),
    currency_code VARCHAR(10),
    created_timestamp VARCHAR(50)
)
```

#### **Each subflow inserts its results (Single-Row, inside loop):**

```sql
INSERT INTO staging_{correlationId} (reservation_id, currency_code, created_timestamp)
VALUES (
    {nodeName.currentRow.RESERVATION_ID},
    {nodeName.currentRow.CURRENCY_CODE},
    {nodeName.currentRow.CREATED_TIMESTAMP}
)
```

#### **Copy to final table and clean up (Single-Row, end of main flow):**

```sql
INSERT INTO final_table (reservation_id, currency_code, created_timestamp)
SELECT reservation_id, currency_code, created_timestamp
FROM staging_{correlationId};
```

```sql
DROP TABLE staging_{correlationId};
```

If the flow completes successfully, the staging table is dropped in Step 3 — no cleanup needed. If the flow fails before reaching Step 3, the staging table is left orphaned in the database. Since each run uses a unique `correlationId`, there is no collision between runs — but orphaned tables will accumulate over time.

{% hint style="info" %}

{% endhint %}

### Using `correlationId` as a Table Field

Instead of creating a separate table per execution, you can use a single permanent staging table with `correlationId` as a column. Each execution tags its own rows, reads only its own data, and cleans up only its own rows at the end.

This approach avoids any DDL operations (CREATE/DROP) during flow execution and leaves no orphaned tables — making it the most self-contained option.

#### **Staging table structure (created once, not per execution)**

```sql
CREATE TABLE staging_table (
    correlation_id VARCHAR(100),
    reservation_id VARCHAR(50),
    currency_code VARCHAR(10),
    created_timestamp VARCHAR(50)
)
```

#### **Each subflow inserts with correlationId (Single-Row, inside loop)**

```sql
INSERT INTO staging_table (correlation_id, reservation_id, currency_code, created_timestamp)
VALUES (
    {correlationId},
    {nodeName.currentRow.RESERVATION_ID},
    {nodeName.currentRow.CURRENCY_CODE},
    {nodeName.currentRow.CREATED_TIMESTAMP}
)
```

#### **Copy only this execution's rows to final table (Single-Row, end of main flow)**

```sql
INSERT INTO final_table (reservation_id, currency_code, created_timestamp)
SELECT reservation_id, currency_code, created_timestamp
FROM staging_table
WHERE correlation_id = '{correlationId}';
```

#### **Clean up only this execution's rows (Single-Row, end of main flow)**

```sql
DELETE FROM staging_table
WHERE correlation_id = '{correlationId}';
```

{% hint style="info" %}
A periodic `DELETE FROM staging_table WHERE created_at < NOW() - INTERVAL '24 hours'` on the database side is enough to handle leftover rows.
{% endhint %}
