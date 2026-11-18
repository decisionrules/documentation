---
description: Network and database prerequisites for Docker and On-Premise deployments.
---

# Prerequisites

## Docker Prerequisites

Before you deploy DecisionRules with Docker, make sure your environment allows outbound traffic to the required DecisionRules services.

### Required network access

Your server must be able to reach these endpoints:

{% hint style="warning" %}
If your environment uses a firewall, proxy, or outbound allowlist, you must allow traffic to both services before deployment.
{% endhint %}

#### License server

DecisionRules uses the license server to validate your license.

* URL: `https://license.decisionrules.io/`
* IP addresses:
  * `75.2.68.203`
  * `99.83.137.90`

**Offline license alternative**

If your environment cannot allow traffic to the license server, you can use an offline license instead.

See [Offline License](offline-license.md) for setup steps.

#### Distribution server

DecisionRules uses the distribution server to deliver the required distribution content.

* URL: `https://distribution.decisionrules.io/`
* IP addresses:
  * `166.117.101.202`
  * `166.117.209.110`

### Database

DecisionRules stores its data in MongoDB or a MongoDB-compatible service. The supported database versions depend on the MongoDB driver bundled in the DecisionRules Server. The server checks the database version when it connects and stops if the database is older than the driver supports.

| DecisionRules Server | MongoDB (self-hosted or MongoDB Atlas) | Amazon DocumentDB (instance-based cluster) | Azure DocumentDB (formerly Cosmos DB vCore) |
| -------------------- | -------------------------------------- | ------------------------------------------ | ------------------------------------------- |
| 1.24.2 and later     | 4.2 – 8.2                              | 5.0, 8.0                                   | 5.0 – 8.0                                   |
| 1.21.4 – 1.23.1      | 4.2 – 8.2                              | 5.0, 8.0                                   | 5.0 – 8.0                                   |
| 1.21.3               | 4.2 – 8.0                              | 5.0, 8.0                                   | 5.0 – 8.0                                   |
| 1.20.0 – 1.21.1      | 4.0 – 8.0                              | 4.0, 5.0, 8.0                              | 5.0 – 8.0 (1.21.1 only)                     |

* MongoDB 9.0 is not supported by any DecisionRules version yet.
* Amazon DocumentDB: set `DB_TYPE=DOCUMENTDB`. On engine versions below 8.0.2, add `retryWrites=false` to `MONGO_DB_URI` and `BI_MONGO_DB_URI`.
* Azure DocumentDB: supported from DecisionRules 1.21.1. Set `DB_TYPE=COSMOSDB_VCORE`. For the setup steps, see [Database - Azure DocumentDB](setup/microsoft-azure-setup/database-azure-cosmosdb.md).
* RU-based Azure Cosmos DB for MongoDB is deprecated and not covered by this table.

{% hint style="warning" %}
Amazon DocumentDB 4.0 is not supported from DecisionRules 1.21.3. It implements the MongoDB 4.0 API, which the MongoDB driver in the DecisionRules Server no longer supports, so the server stops at start-up. Move the cluster to engine 5.0 or 8.0 before you upgrade DecisionRules.
{% endhint %}
