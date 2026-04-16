---
description: >-
  Before you can use database nodes in an Integration Flow, you need to have the
  following in place.
---

# Prerequisites

### A Running, Accessible Database

Your database instance must be reachable from the DecisionRules backend. The exact requirements depend on your deployment:

* **Cloud (SaaS)**: The database must be accessible over the internet from the DecisionRules IP addresses (see IP Whitelisting below).
* **On-Premise**: The database must be accessible from the server where DecisionRules is deployed. Consult your infrastructure team if needed.

#### IP Allowlisting

As part of the database integration prerequisites, make sure to add the Integration Flow IP addresses to your allowlist to enable successful connectivity. List of IP addresses can be found [here](../ip-allowlisting.md).

### A Database Connector

All database nodes require a [**Connector**](../../../space/connectors.md) — a saved connection configuration that stores your host, port, credentials, and database name.

### Schema and Table Permissions

The database user specified in the Connector must have the necessary privileges for the operations your flow will perform:

* `SELECT` — for read queries
* `INSERT`, `UPDATE`, `DELETE` — for write operations
* `CREATE TABLE`, `DROP TABLE` — if your flow creates or manages tables (e.g. temporary tables)

Limit permissions to only what is required by the Flow to follow the principle of least privilege.
