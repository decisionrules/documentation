---
description: >-
  Here, you can find a tutorial on how to setup a Redis Cache on Azure to work
  with DecisionRules.
cover: >-
  https://images.unsplash.com/photo-1597200381847-30ec200eeb9a?crop=entropy&cs=srgb&fm=jpg&ixid=MnwxOTcwMjR8MHwxfHNlYXJjaHwzfHxBenVyZXxlbnwwfHx8fDE2NTI2ODQxOTE&ixlib=rb-1.2.1&q=85
coverY: 0
---

# Cache - Azure Cache for Redis

## Creating Azure Cache for Redis

After navigating navigating to **Azure Cache for Redis**, hit Create. In the following screen assign your Resource group, give the cache a DNS name, choose a location and assing the **Standard C1** type. The type selection is up to you but we recommend a cache with at least 1GB of storage.&#x20;

<figure><img src="../../../.gitbook/assets/image (287).png" alt=""><figcaption><p>Basic Azure Cache for Redis settings</p></figcaption></figure>

Next up is the Networking settings.&#x20;

{% hint style="warning" %}
It is recommended to use a Private Endpoint connection but for hassle free non-Prod environment deployments a Public Endpoint is also an option.
{% endhint %}

After selecting **Private Endpoint** click Add private endpoint and fill in the settings. Location and resource group settings should correspond to those of your server containers'.&#x20;

<figure><img src="../../../.gitbook/assets/image (286).png" alt=""><figcaption><p>Networking settings</p></figcaption></figure>

Keep the rest of the settings default unless your use-case demands otherwise. Optionally also add tags for easier resource management.

Validate your settings and create the cache.

## Necessary settings and connection strings

**Maxmemory policy**

After the cache has been provisioned, navigate to it's Settings/Advanced Settings tab. Once there, change the Maxmemory policy to **allkeys-lru** or **allkeys-lfu**.

**Connection string**

The format of your connection string will depend on whether you're using SSL or non-SSL connection.

* **SSL** - `rediss://<access_key>@<hostname>:<port>`
* **Non-SSL** - `redis://<access_key>@<hostname>:<port>`

Note the difference is in the first part of the string `rediss://` x `redis://`.

* You can find the `<access_key>` under Settings / Access keys
* You can find the `<hostname>` and `<port>` under Settings / Properties

{% hint style="info" %}
Azure Cache for Redis tends to idle after a period of inactivity (10 minutes). To prevent this, and the corresponding expensive cache misses, we recommend setting the REDIS\_PING\_INTERVAL optional Environment Variable.
{% endhint %}



