---
description: >-
  Following are steps for Azure Cosmos DB deployment for integration with
  DecisionRules.
cover: >-
  https://images.unsplash.com/photo-1597200381847-30ec200eeb9a?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwzfHxBenVyZXxlbnwwfHx8fDE2NTI2ODQxOTE&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Database - Azure CosmosDB

After navigating to Azure Cosmos DB, hit Create. Choose **Azure Cosmos DB for MongoDB**. When prompted, select the Request unit (RU) based account. vCore cluster should also work but we've seen a number of issues arise when working with it.&#x20;

<figure><img src="../../../.gitbook/assets/image (288).png" alt=""><figcaption><p>Cosmos DB for MongoDB -> Request unit (RU) database account</p></figcaption></figure>

Assign your resource group, give the account a name, choose a location and choose the **Serverless** capacity mode.

{% hint style="info" %}
Serverless Capacity mode has much lower operating costs compared to the Provisioned Throughput option. If for whatever reason you decide to go with the Provisioned Throughput option anyways, make sure to set the limit to a minimum of 12000 RUs.
{% endhint %}

<figure><img src="../../../.gitbook/assets/image (289).png" alt=""><figcaption><p>Basic settings</p></figcaption></figure>

Set your **Global Distributions** settings, i kept mine default. Next go to the Networking tab and fill in the settings.&#x20;

{% hint style="warning" %}
It is recommended to use a Private Endpoint connection but for hassle free non-Prod environment deployments a Public Endpoint is also an option.
{% endhint %}

Create your private endpoint, making sure it shares the same virtual network as your future server container.

<figure><img src="../../../.gitbook/assets/image (291).png" alt=""><figcaption><p>Networking settings and Private Endpoint</p></figcaption></figure>

For the Backup Policy, Encryption and Tags choose whatever fits your use-case. Review the account and create.

#### Where to find a connection string

After the database account has been created, navigate to Settings / Connection strings. The connection string can be found under **Primary/Secondary connection string**.

{% hint style="warning" %}
If you use Cosmos DB you need to specify the DB\_TYPE environmental variable in your server container. More information here: [containers-environmental-variables.md](../containers-environmental-variables.md "mention")
{% endhint %}
