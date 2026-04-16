---
description: >-
  This page describes the known limitations and constraints that apply when
  using database nodes in Integration Flow.
---

# Technical Limits

## Query Result Preview Limit

When testing a query directly in the node configuration (using the **Test Query** feature), the results preview is limited to **25 rows**. This is a UI constraint only — the actual query executed at runtime returns all rows the query produces.

## Temporary Tables

Temporary tables (created using `CREATE TEMP TABLE`) are supported in Flow, but come with two important constraints you need to be aware of before using them.

### Use Single-Row Nodes Only

A temporary table exists only within the database connection that created it — it is invisible to any other connection. Because of this, **every node that interacts with a temporary table must be a Single-Row node**.

This is because Single-Row nodes reuse the same database connection throughout the entire flow. Multi-row nodes do not have this guarantee — they may open a different connection, and since the temporary table does not exist on that connection, the query will fail.

### Temporary Tables Are Not Visible Across Flow Boundaries

Each flow — whether a main flow or a subflow — operates on its own database connection. Session-scoped objects like temporary tables are tied to that connection and are not shared.

In practice this means:

* A temporary table created in the **main flow** cannot be read or written by a **subflow**.
* A temporary table created in a **subflow** is gone by the time the subflow returns — the main flow cannot access it.

This applies equally in both directions. The flows simply do not share a connection, so they cannot see each other's temporary state.

If you need to share data between a main flow and a subflow, pass it through **flow input/output variables**, or persist it to a regular (permanent) table and read it from there.

## Integration Flow instead of Decision Flow

Database nodes are available in both Decision Flow and Integration Flow, but the two differ significantly in how long they can run — and that difference matters a lot for database operations.

**Decision Flow** has a hard execution limit of **1–8 seconds** (depending on your plan or on-premise configuration). Any database query that takes longer than the remaining time will cause the entire flow to fail with a timeout. This makes Decision Flow suitable only for fast, lightweight queries — simple lookups or single-row fetches where you can guarantee a short response time.

**Integration Flow** was built for longer-running work. The flow itself can run for up to **24 hours**, and database nodes can stay active as long as there is ongoing activity — though any single query that produces no activity for **5 minutes** will be terminated.

See [Decision Flow vs. Integration Flow](https://docs.decisionrules.io/doc/rules/flow/decision-flow-vs.-integration-flow) for a full comparison.
