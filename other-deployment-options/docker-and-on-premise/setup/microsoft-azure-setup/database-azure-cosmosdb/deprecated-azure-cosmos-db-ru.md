---
description: >-
  RU-based Azure Cosmos DB for MongoDB is deprecated. Use Azure DocumentDB for
  new environments and move existing ones to it.
---

# Deprecated: Azure Cosmos DB for MongoDB (RU)

{% hint style="danger" %}
RU-based Azure Cosmos DB for MongoDB is **deprecated**. Do not use it for new environments. Use [Azure DocumentDB](./) (formerly Cosmos DB vCore) instead, following Microsoft's own recommendation, and plan to move existing RU-based environments to it.
{% endhint %}

This page is kept for existing RU-based environments only.

## Limitations

* **Space Versioning is not supported.** Enabling it is refused with _"Space Versioning is not supported on Azure Cosmos DB for MongoDB (RU). Use MongoDB or Azure Cosmos DB for MongoDB (vCore)."_ The `SPACE_VERSIONING_ALLOW_NON_TRANSACTIONAL_WRITES` variable does not change that. See [Self-Hosted Requirements](../../../../../space/space-version-control/self-hosted-requirements.md).
* **Raw Data Table sorting.** Some sort orders cannot be served and are refused with _"This Raw Data Table sort is not supported by the current database provider. Reset sorting and try again."_
* **Wire compression.** Leave compression disabled. See [MongoDB Wire Compression](../../../mongodb-wire-compression.md).

## Moving to Azure DocumentDB

1. Create an Azure DocumentDB cluster as described in [Database - Azure DocumentDB](./).
2. Copy your data to the new cluster. Copy the data only, not the indexes: DecisionRules creates its indexes when it starts.
3. Point `MONGO_DB_URI` and `BI_MONGO_DB_URI` to the new cluster and set `DB_TYPE=COSMOSDB_VCORE` on both the server and the Business Intelligence containers.

{% hint style="info" %}
Contact our support before you move a production environment.
{% endhint %}

## Setting up an RU-based account

Assign your resource group, give the account a name, choose a location and choose the **Serverless** capacity mode.

{% hint style="info" %}
Serverless Capacity mode has much lower operating costs compared to the Provisioned Throughput option. If for whatever reason you decide to go with the Provisioned Throughput option anyways, make sure to set the limit to a minimum of 12000 RUs.
{% endhint %}

<figure><img src="../../../../../.gitbook/assets/image (289).png" alt=""><figcaption><p>Basic settings</p></figcaption></figure>

Set your Global Distributions settings if needed. Next go to the Networking tab and fill in the settings.

{% hint style="warning" %}
It is recommended to use a Private Endpoint connection but for hassle free non-Prod environment deployments a Public Endpoint is also an option.
{% endhint %}

Create your private endpoint, making sure it shares the same virtual network as your future server container.

<figure><img src="../../../../../.gitbook/assets/image (291).png" alt=""><figcaption><p>Networking settings and Private Endpoint</p></figcaption></figure>

For the Backup Policy, Encryption and Tags choose whatever fits your use-case. Review the account and create.

#### Where to find a connection string

After the database account has been created, navigate to Settings / Connection strings. The connection string can be found under **Primary/Secondary connection string**.

{% hint style="danger" %}
If you use RU-based Cosmos DB you need to specify the **DB\_TYPE** environmental variable in your server and Business Intelligence containers with value **COSMOSDB**. More information here: [containers-environmental-variables.md](../../../containers-environmental-variables.md "mention")
{% endhint %}
