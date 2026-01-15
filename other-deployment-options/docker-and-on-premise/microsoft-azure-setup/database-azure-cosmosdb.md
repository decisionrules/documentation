---
description: >-
  Following are steps for Azure Cosmos DB deployment for integration with
  DecisionRules.
cover: >-
  https://images.unsplash.com/photo-1597200381847-30ec200eeb9a?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwzfHxBenVyZXxlbnwwfHx8fDE2NTI2ODQxOTE&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Database - Azure CosmosDB

After navigating to Azure Cosmos DB, hit Create. Choose **Azure DocumentDB (with MongoDB compatibility)**.&#x20;

{% hint style="info" %}
From version 1.21.0, we recommend using the Azure DocumentDB (formerly vCore) type instead of RU-based type for new environments, following Microsoft’s own recommendation.
{% endhint %}

<figure><img src="../../../.gitbook/assets/image (396).png" alt=""><figcaption><p>DocumentDB (with MongoDB Compatibility)</p></figcaption></figure>

## Azure DocumentDB (formerly vCore)

Assign your resource group, give the cluster a name, choose a location and choose the cluster tier and version if necessary.

<figure><img src="../../../.gitbook/assets/image (397).png" alt=""><figcaption><p>Basic settings</p></figcaption></figure>

Next go to the Networking tab and fill in the settings.&#x20;

{% hint style="warning" %}
It is recommended to use a Private Endpoint connection but for hassle free non-Prod environment deployments a Public Endpoint is also an option.
{% endhint %}

Create your private endpoint, making sure it shares the same virtual network as your future server container.

<figure><img src="../../../.gitbook/assets/image (398).png" alt=""><figcaption><p>Networking settings and Private Endpoint</p></figcaption></figure>

For the Global distribution, Encryption and Tags choose whatever fits your use-case. Review the account and create.

{% hint style="danger" %}
If you use Azure DocumentDB (formerly called vCore-based Cosmos DB) you need to specify the **DB\_TYPE** environmental variable in your server container with value **COSMOSDB\_VCORE**. More information here: [containers-environmental-variables.md](../containers-environmental-variables.md "mention")
{% endhint %}

## RU-based

Assign your resource group, give the account a name, choose a location and choose the **Serverless** capacity mode.

{% hint style="info" %}
Serverless Capacity mode has much lower operating costs compared to the Provisioned Throughput option. If for whatever reason you decide to go with the Provisioned Throughput option anyways, make sure to set the limit to a minimum of 12000 RUs.
{% endhint %}

<figure><img src="../../../.gitbook/assets/image (289).png" alt=""><figcaption><p>Basic settings</p></figcaption></figure>

Set your Global Distributions settings if needed. Next go to the Networking tab and fill in the settings.&#x20;

{% hint style="warning" %}
It is recommended to use a Private Endpoint connection but for hassle free non-Prod environment deployments a Public Endpoint is also an option.
{% endhint %}

Create your private endpoint, making sure it shares the same virtual network as your future server container.

<figure><img src="../../../.gitbook/assets/image (291).png" alt=""><figcaption><p>Networking settings and Private Endpoint</p></figcaption></figure>

For the Backup Policy, Encryption and Tags choose whatever fits your use-case. Review the account and create.

#### Where to find a connection string

After the database account has been created, navigate to Settings / Connection strings. The connection string can be found under **Primary/Secondary connection string**.

{% hint style="danger" %}
If you use RU-based Cosmos DB you need to specify the **DB\_TYPE** environmental variable in your server container with value **COSMOSDB**. More information here: [containers-environmental-variables.md](../containers-environmental-variables.md "mention")
{% endhint %}
