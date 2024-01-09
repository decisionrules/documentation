---
description: >-
  Here, you can find a tutorial on how to setup a Redis Elasticache to work with
  DecisionRules.
---

# Cache - Amazon ElastiCache

## Creating a Redis based Amazon ElastiCache

Open ElastiCache Dashboard In the AWS Console, select ElastiCache. Hit **Get started** and select **Redis.** Click **Design your own cache** and select the **Cluster cache** method. Cluster mode **Disabled**.

Choose a name for your cluster and continue to Cluster settings. There, keep everything default apart from the Node type where I recommend you choose **cluster.t4g.micro.**

<figure><img src="../../.gitbook/assets/image (315).png" alt=""><figcaption></figcaption></figure>

Next in Connectivity choose Create a new subnet group, give it a name and choose your VPC.

<figure><img src="../../.gitbook/assets/image (316).png" alt=""><figcaption></figcaption></figure>

Next up the Advanced settings.

Assign the cache your preffered security groups, for the purposes of this tutorial I only use the default one.

I choose to disable automatic backups as DecisionRules uses Redis only for caching and not as operational storage.

Keep the rest of the settings default and hit **Next.** Review the settings and **Create.**

## Necessary settings and connection strings

#### Maxmemory policy

Navigate to **ElastiCache / Configurations / Parameter groups**. Click **Create parameter group**. Here assign the parameter group a name and for the **Family** setting choose **redis7.** Hit **Create.**

Go to the newly created parameter group and click **Edit parameter values.** Search for **maxmemory-policy**. For the value of this policy select either **allkeys-lfu or allkeys-lru.** Hit **Save changes.**

<figure><img src="../../.gitbook/assets/image (330).png" alt=""><figcaption></figcaption></figure>

#### Connection string

To find your connection string navigate to your redis ElastiCache and there under **Cluster details** look for **Primary endpoint.**

The **connection string** will have the following format: `redis://<primary_endpoint>`

**For ease-of-use below are the necessary settings in list form:**

* **Engine**: Redis
* **Engine version**: 6 and newer
* **Port**: 6379
* **Number of replicas**: 2
* **Multi-AZ**: Yes
* **Advanced Redis settings:**
  * **Subnet group**: Same as DecisionRules server app
  * **Availability zones placement**: No preference
* **Security:**
  * **Security groups**: Same as DecisionRules server app
  * **Encryption at-rest**: No
  * **Encryption in-transit**: No
