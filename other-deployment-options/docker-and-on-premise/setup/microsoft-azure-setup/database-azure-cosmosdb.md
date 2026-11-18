---
description: >-
  Following are steps for Azure DocumentDB deployment for integration with
  DecisionRules.
cover: >-
  https://images.unsplash.com/photo-1597200381847-30ec200eeb9a?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwzfHxBenVyZXxlbnwwfHx8fDE2NTI2ODQxOTE&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Database - Azure DocumentDB

After navigating to Azure Cosmos DB, hit Create. Choose **Azure DocumentDB (with MongoDB compatibility)**.

{% hint style="info" %}
RU-based Azure Cosmos DB for MongoDB is deprecated. For existing RU-based environments, see [Deprecated: Azure Cosmos DB for MongoDB (RU)](database-azure-cosmosdb/deprecated-azure-cosmos-db-ru.md).
{% endhint %}

<figure><img src="../../../../.gitbook/assets/image (396).png" alt=""><figcaption><p>DocumentDB (with MongoDB Compatibility)</p></figcaption></figure>

## Azure DocumentDB (formerly vCore)

Assign your resource group, give the cluster a name, choose a location and choose the cluster tier and version if necessary.

<figure><img src="../../../../.gitbook/assets/image (397).png" alt=""><figcaption><p>Basic settings</p></figcaption></figure>

Next go to the Networking tab and fill in the settings.

{% hint style="warning" %}
It is recommended to use a Private Endpoint connection but for hassle free non-Prod environment deployments a Public Endpoint is also an option.
{% endhint %}

Create your private endpoint, making sure it shares the same virtual network as your future server container.

<figure><img src="../../../../.gitbook/assets/image (398).png" alt=""><figcaption><p>Networking settings and Private Endpoint</p></figcaption></figure>

For the Global distribution, Encryption and Tags choose whatever fits your use-case. Review the account and create.

{% hint style="danger" %}
If you use Azure DocumentDB (formerly called vCore-based Cosmos DB) you need to specify the **DB\_TYPE** environmental variable in your server container with value **COSMOSDB\_VCORE**. More information here: [containers-environmental-variables.md](../../containers-environmental-variables.md "mention")
{% endhint %}
